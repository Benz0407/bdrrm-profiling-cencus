import 'package:mobile/model/user_model.dart';
import 'package:mobile/util/responsive.dart';
import 'package:mobile/widgets/bar_graph_widget.dart';
import 'package:mobile/widgets/line_chart_card.dart';
import 'package:mobile/widgets/summary_widget.dart';
import 'package:mobile/widgets/header_widget.dart';
import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  final User user;
  const DashboardWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 18),
            HeaderWidget(user: user),
            const SizedBox(height: 18),
            const SizedBox(height: 18),
            const LineChartCard(),
            const SizedBox(height: 18),
            const BarGraphCard(),
            const SizedBox(height: 18),
            if (Responsive.isTablet(context)) SummaryWidget(user: user),
          ],
        ),
      ),
    );
  }
}
