import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:group_9_birumanchu/pages/shopping_form.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late Future<CameraPosition> _currentLocation;
  // StreamSubscription? _storeLocationSubscription;
  static final LatLng _kMapCenter1 = LatLng(35.7162, 139.7254);

  Set<Marker> _createMarker() {
    return {
      Marker(
        markerId: MarkerId("marker_1"),
        position: _kMapCenter1,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 10,),
                      const Text(
                        'username',
                        style: TextStyle(
                          fontSize: 25
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 15,),
                  const Text(
                    '時間',
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    '宛先',
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    '頼めるお店',
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                  SizedBox(height: 20),
                  Center( // ボタンを中央に配置
                    child: ElevatedButton(
                      child: const Text('依頼する'),
                      onPressed: () => Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FormPage())),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    };
  }

  @override
  void initState() {
    super.initState();
    _currentLocation = _initCurrentLocation();
  }

  Future<CameraPosition> _initCurrentLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return const CameraPosition(target: LatLng(0, 0), zoom: 14);
    }

    if (await Geolocator.checkPermission() == LocationPermission.denied &&
        await Geolocator.requestPermission() == LocationPermission.denied) {
      return const CameraPosition(target: LatLng(0, 0), zoom: 14);
    }

    final Position position = await Geolocator.getCurrentPosition();
    return CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CameraPosition>(
        future: _currentLocation,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 90),
              child: Container(
                color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: GoogleMap(
                    initialCameraPosition: snapshot.data!,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    markers: _createMarker(),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
