import 'package:eventique_admin_dashboard/color.dart';
import 'package:eventique_admin_dashboard/models/side_menu_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<MenuModel> _menuData = [
      const MenuModel(icon: Icons.bubble_chart, title: 'Business Overview'),
      const MenuModel(icon: Icons.people, title: 'Customers'),
      const MenuModel(icon: Icons.add_box, title: 'Add To App'),
    ];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: onPrimary,
            offset: Offset(
              1.0,
              1.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'EvenTique',
            style: TextStyle(
              color: primary,
              fontFamily: 'IrishGrover',
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _menuData.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(6.0),
                      ),
                      color: isSelected
                          ? secondary.withOpacity(0.6)
                          : Colors.transparent,
                    ),
                    child: InkWell(
                      onTap: () => setState(() {
                        selectedIndex = index;
                      }),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 7),
                            child: Icon(
                              _menuData[index].icon,
                              color: isSelected ? primary : Colors.grey,
                            ),
                          ),
                          Text(
                            _menuData[index].title,
                            style: TextStyle(
                              fontFamily: 'CENSCBK',
                              fontSize: 16,
                              color: isSelected ? white : Colors.grey,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
