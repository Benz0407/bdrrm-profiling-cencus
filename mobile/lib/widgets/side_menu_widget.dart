import 'package:flutter/material.dart';
import 'package:mobile/census/census_data.dart';
import 'package:mobile/const/constant.dart';
import 'package:mobile/data/side_menu_data.dart';
import 'package:mobile/model/user_model.dart';
import 'package:mobile/services/login_service.dart';
import 'package:provider/provider.dart';


class SideMenuWidget extends StatefulWidget {
  final User user;
  const SideMenuWidget({super.key, required this.user});
  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final data = SideMenuData();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: const Color(0xFFE1F5FE),
      child: ListView.builder(
        itemCount: data.menu.length,
        itemBuilder: (context, index) => buildMenuEntry(data, index),
      ),
    );
  }

  Widget buildMenuEntry(SideMenuData data, int index) {
    final isSelected = selectedIndex == index;
    final loginProvider = Provider.of<LoginService>(context, listen: false);
    // Visibility check based on userType
    final isMenuVisible = widget.user.userType == 'Mnow' || index != 1;
    return Visibility(
      visible: isMenuVisible,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          color: isSelected ? selectionColor : Colors.transparent,
        ),
        child: InkWell(
          onTap: () {
            if (index == 1) {
              // Check if it's the "Census" item (index 1)
              Navigator.push(
                context,
                // MaterialPageRoute(builder: (context) => const CensusMain()),
                MaterialPageRoute(
                    builder: (context) => CensusData(user: widget.user)),
              );
            } else if (index == 2) {
              loginProvider.signOutUser();
              // Assuming secure storage
      
               Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
            } else {
              setState(() {
                selectedIndex = index;
              });
            }
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                child: Icon(
                  data.menu[index].icon,
                  color: isSelected ? Colors.blue : Colors.black,
                ),
              ),
              Text(
                data.menu[index].title,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? Colors.blue : Colors.black,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
