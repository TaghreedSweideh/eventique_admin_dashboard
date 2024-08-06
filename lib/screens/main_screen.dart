import 'package:eventique_admin_dashboard/responsive.dart';
import 'package:eventique_admin_dashboard/widgets/dashboard.dart';
import 'package:eventique_admin_dashboard/widgets/side_menu.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main-screen';
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenu(),
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop)
              SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                child: SideMenu(),
              ),
            Expanded(
              flex: 7,
              child: Dashboard(),
            ),
          ],
        ),
      ),
    );
  }
}
