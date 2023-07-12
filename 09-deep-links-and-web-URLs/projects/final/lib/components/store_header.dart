import 'package:flutter/material.dart';

class StoreHeader extends StatelessWidget {
  final String logoUrl;
  final String storeName;
  final String address;
  final String openHours;
  final String hotline;

  const StoreHeader({
    super.key,
    required this.logoUrl,
    required this.storeName,
    required this.address,
    required this.openHours,
    required this.hotline,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Image.network(
                  logoUrl,
                  fit: BoxFit.cover,
                  // height: 200,
                  // width: 200,
                ),
                // Positioned(
                //   bottom: 0,
                //   right: 0,
                //   child: Image.asset(
                //     'assets/images/store_logo.png', // replace with your local image path
                //     height: 40,
                //     width: 40,
                //   ),
                // ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  storeName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(address),
                Text('Open Hours: $openHours'),
                Text('Hotline: $hotline'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
