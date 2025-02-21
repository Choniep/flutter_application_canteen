import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_canteen/components/my_food_tile.dart';
import 'package:flutter_application_canteen/models/food.dart';
import 'package:flutter_application_canteen/models/restaurant.dart';
import 'package:flutter_application_canteen/pages/student/food_page.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class HomeStanPage extends StatefulWidget {
  const HomeStanPage({super.key});

  @override
  State<HomeStanPage> createState() => _HomeStanPageState();
}

class _HomeStanPageState extends State<HomeStanPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Stand Performance',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Stats Grid
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildStatCard(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.blue,
                  title: 'Total Orders',
                  value: '0',
                  subtitle: 'All time',
                ),
                _buildStatCard(
                  icon: Icons.inventory_2,
                  iconColor: Colors.green,
                  title: 'Items Sold',
                  value: '0',
                  subtitle: 'All items',
                ),
                _buildStatCard(
                  icon: Icons.payments,
                  iconColor: Colors.orange,
                  title: 'Average Order',
                  value: 'Rp 0',
                  subtitle: 'Per transaction',
                ),
                _buildStatCard(
                  icon: Icons.trending_up,
                  iconColor: Colors.indigo,
                  title: 'This Month',
                  value: 'Rp 0',
                  subtitle: 'Total income',
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Income Trend Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Income Trend',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Last 6 months',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.trending_up,
                        color: Colors.blue,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Monthly',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Chart
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          const titles = ['Sep', 'Oct', 'Nov', 'Dec', 'Jan', 'Feb'];
                          final int index = value.toInt();
                          if (index < 0 || index >= titles.length) {
                            return const Text('');
                          }
                          return Text(
                            titles[index],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 45,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}K',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 300),
                        FlSpot(1, 100),
                        FlSpot(2, 500),
                        FlSpot(3, 170),
                        FlSpot(4, 400),
                        FlSpot(5, 100),
                      ],
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 2,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: Colors.blue,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Top Selling Items Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Items Sold',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}

Widget _buildStatCard({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String value,
  required String subtitle,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
