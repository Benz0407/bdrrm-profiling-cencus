import 'package:mobile/model/user_model.dart';
import 'package:mobile/util/responsive.dart';
import 'package:mobile/widgets/dashboard_widget.dart';
import 'package:mobile/widgets/side_menu_widget.dart';
import 'package:mobile/widgets/summary_widget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {

  final User user; 

  const MainScreen({super.key, required this.user});


  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      drawer: !isDesktop
          ?  SizedBox(
              width: 250,
              child: SideMenuWidget(user: user),
            )
          : null,
      endDrawer: Responsive.isMobile(context)
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child:  SummaryWidget(user: user),
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop)
              Expanded(
                flex: 2,
                child: SizedBox(
                  child: SideMenuWidget(user: user),
                ),
              ),
            Expanded(
              flex: 7,
              child: DashboardWidget(user: user),
            ),
            if (isDesktop)
              Expanded(
                flex: 3,
                child: SummaryWidget(user: user),
              ),
          ],
        ),
      ),
    );
  }
}
