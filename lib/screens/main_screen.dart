import 'package:eventique_admin_dashboard/responsive.dart';
import 'package:eventique_admin_dashboard/screens/add_to_app.dart';
import 'package:eventique_admin_dashboard/widgets/dashboard.dart';
import 'package:eventique_admin_dashboard/widgets/side_menu.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main-screen';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    Widget _getSelectedScreen() {
      switch (_selectedIndex) {
        case 1:
          return Dashboard(); // Add the corresponding screen widget
        case 2:
          return AddToApp();
        default:
          return Dashboard();
      }
    }

    return Scaffold(
      drawer: !isDesktop
          ? SizedBox(
              width: 250,
              child: SideMenu(
                onMenuItemSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop)
              SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                child: SideMenu(
                  onMenuItemSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
            Expanded(
              flex: 7,
              child: _getSelectedScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
