import 'package:flutter/material.dart';

class CensusHeaderWidget extends StatelessWidget {
  final String headerText;
  const CensusHeaderWidget({super.key, required this.headerText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36.0, 0.0, 16.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 0),
              Image.asset(
                'assets/icons/logo1.png',
                width: 200.0,
                height: 150,
              ),
              const SizedBox(width: 0),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //The the parameter passed in the method call
                      headerText,
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 0),
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
          ),
        ],
      ),
    );
  }
}
