import 'package:flutter/material.dart';
import 'package:mobile/model/user_model.dart';
import 'package:mobile/util/responsive.dart';

class HeaderWidget extends StatelessWidget {
  final User user;
  const HeaderWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36.0, 0.0, 16.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Adjust layout based on screen size
          Responsive.isMobile(context)
              ? _buildMobileHeader(context)
              : _buildDesktopHeader(context),
        ],
      ),
    );
  }

  Widget _buildMobileHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/icons/logo1.png',
          width: 200.0,
          height: 150.0,
        ),
        const SizedBox(height: 16.0),
        Text(
          'Welcome To Profiling, ${user.userName}!',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'San Fernando, Camarines Sur, Barangay Bonifacio.',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue[400],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/logo1.png',
          width: 200.0,
          height: 150.0,
        ),
        const SizedBox(width: 16.0),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome To Profiling, ${user.userName}!',
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'San Fernando, Camarines Sur, Barangay Bonifacio.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue[400],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}