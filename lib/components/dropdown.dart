//Creates dropdown options for picking search radius and initializes location tracking.
// Converts selected radius from miles to meters
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as notif;

import '../main.dart';

String globalCoordinates = '';

class DropdownQuestion extends StatefulWidget {
  final String question;
  final List<int> selectedRadius;
  final Function(bool isAnswered, String question, int radius) onSelected;
  const DropdownQuestion({
    Key? key,
    required this.question,
    required this.selectedRadius,
    required this.onSelected,
  }) : super(key: key);

  @override
  _DropdownQuestionState createState() => _DropdownQuestionState();
}

class _DropdownQuestionState extends State<DropdownQuestion> {
  int radius = 1;
  Future<void> requestNotificationPermission() async {
    if (await notif.Permission.notification.isDenied) {
      await notif.Permission.notification.request();
    }
  }

  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  Future<dynamic> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) _serviceEnabled = await location.requestService();
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }
    _locationData = await location.getLocation();

    return _locationData;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            widget.question,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 100,
          height: 80,
          child: DropdownButton<int>(
            value: radius,
            icon: const Icon(
              Icons.arrow_downward,
              size: 40,
              color: Colors.blue,
            ),
            elevation: 26,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 50,
            ),
            underline: Container(
              height: 5,
              color: Colors.blue,
            ),
            onChanged: (int? value) {
              if (value != null) {
                setState(() {
                  requestNotificationPermission();
                  getLocation();
                  getLocation().then((coord) {
                    Globals.coordinates =
                        '${coord.latitude}, ${coord.longitude}';
                    print(Globals.coordinates);
                  });
                  radius = value;
                  Globals.Radius = radius * 1609.34;
                });
                widget.onSelected(true, widget.question, radius);
              }
            },
            items:
                widget.selectedRadius.map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
