import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  // get instance of firebase auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  String? currentUserId; // buat simpen UID

  // sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      // sign user in
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      currentUserId = userCredential.user!.uid;

      // fetch user role from Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection('user')
          .doc(userCredential.user!.uid)
          .get();
      String role = userDoc['role'];

      // return user credential along with role
      return userCredential;
    }

    // catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign up
  Future<UserCredential> signUpWithEmailPassword(
      String email, password, username, role) async {
    try {
      // create user with each email and password
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // take user UID
      String uid = userCredential.user!.uid;

      // simpen UID
      currentUserId = userCredential.user!.uid;

      // save to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'username': username,
        'role': role,
      });

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // check if profile exist
  Future<bool> checkProfileExists(String uid, String role) async {
    try {
      final collection = role == 'siswa' ? 'students' : 'stan';
      final doc = await _firestore.collection(collection).doc(uid).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }

  // Create siswa profile
  Future<void> createSiswaProfile({
    required String uid,
    required String namaSiswa,
    required String alamat,
    required String telp,
    String? fotoUrl,
  }) async {
    try{
      await _firestore.collection('siswa').doc(uid).set({
        'uid': uid,
        'namaSiswa': namaSiswa,
        'alamat': alamat,
        'telp': telp,
        'fotoUrl': fotoUrl,
      });
    } catch (e) {
      rethrow;
    }
  }

  // create stan profile
  Future<void> createStanProfile({
    required String uid,
    required String namaStan,
    required String namaPemilik,
    required String telp,
  }) async {
    try {
      await _firestore.collection('stan').doc(uid).set({
        'uid': uid,
        'nama_stan': namaStan,
        'nama_pemilik': namaPemilik,
        'telp': telp,
      });
    } catch (e) {
      rethrow;
    }
  }

  // sign out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
