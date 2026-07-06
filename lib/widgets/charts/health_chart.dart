import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../config/theme.dart';

class HealthChart extends StatelessWidget {
  const HealthChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Visit History',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Last 6 months',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        const months = [
                          'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'
                        ];
                        if (value.toInt() < months.length) {
                          return Text(
                            months[value.toInt()],
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppTheme.textSecondary,
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 3),
                      FlSpot(1, 4),
                      FlSpot(2, 2),
                      FlSpot(3, 5),
                      FlSpot(4, 3),
                      FlSpot(5, 4),
                    ],
                    isCurved: true,
                    color: AppTheme.primaryColor,
                    barWidth: 3,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: Colors.white,
                          strokeWidth: 2,
                          strokeColor: AppTheme.primaryColor,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppTheme.primaryColor.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
