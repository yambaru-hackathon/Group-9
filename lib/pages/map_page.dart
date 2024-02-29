import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:group_9_birumanchu/pages/shopping_form.dart';
import 'package:group_9_birumanchu/service/userDatabase.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  StreamSubscription? _storeLocationSubscription;
  late String? _userId;

  String? getCurrentUserUid() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // ユーザーがログインしている場合、UIDを取得して返します
      return user.uid;
    } else {
      // ユーザーがログインしていない場合の処理
      print('User is not logged in.');
      return null; // もしくは別の適切な値を返します
    }
  }

  @override
  void initState() {
    // _userId = _generateRandomUserId();
    _fetchMarkersStream();
    _subscribeToLocationChanges();
    super.initState();
    _initializeUserId();
  }

  Future<void> _initializeUserId() async {
    final userId = getCurrentUserUid();
    setState(() {
      _userId = userId;
    });
  }

  @override
  void dispose() {
    _storeLocationSubscription?.cancel();
    super.dispose();
  }

  /// store current location information when location changed
  void _subscribeToLocationChanges() async {
    _storeLocationSubscription = Geolocator.getPositionStream(
            locationSettings: const LocationSettings(distanceFilter: 20))
        .listen((Position? position) async {
      FirebaseFirestore.instance.collection('locations').doc(_userId).set({
        'latitude': position?.latitude,
        'longitude': position?.longitude,
        'timestamp': FieldValue.serverTimestamp(),
      });
    });
  }

  /// subscribe to location changes from Firestore
  Stream<Set<Marker>> _fetchMarkersStream() => FirebaseFirestore.instance
      .collection('locations')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .where((doc) => doc.id != _userId)
          .map(_convertToMarker)
          .toSet());

  Marker _convertToMarker(doc) {
    final data = doc.data();
    final user = doc.id;
    double latitude = data['latitude'];
    double longitude = data['longitude'];
    DateTime dateTime = data['timestamp'].toDate();

    double color =
        dateTime.isBefore(DateTime.now().subtract(const Duration(days: 1)))
            ? BitmapDescriptor.hueYellow
            : BitmapDescriptor.hueAzure;
    return Marker(
      markerId: MarkerId(user),
      position: LatLng(latitude, longitude),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '$user',
                    style: TextStyle(fontSize: 25),
                  ),
                ]),
                SizedBox(
                  height: 15,
                ),
                const Text(
                  '時間',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                const Text(
                  '宛先',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                const Text(
                  '頼めるお店',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Center(
                  // ボタンを中央に配置
                  child: ElevatedButton(
                    child: const Text('依頼する'),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FormPage())),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<CameraPosition> _initCurrentLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return const CameraPosition(target: LatLng(0, 0), zoom: 16);
    }

    if (await Geolocator.checkPermission() == LocationPermission.denied &&
        await Geolocator.requestPermission() == LocationPermission.denied) {
      return const CameraPosition(target: LatLng(0, 0), zoom: 16);
    }

    return Geolocator.getCurrentPosition()
        .then((value) => CameraPosition(
            target: LatLng(value.latitude, value.longitude), zoom: 16))
        .onError((error, stackTrace) =>
            const CameraPosition(target: LatLng(0, 0), zoom: 16));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 90),
          child: Container(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FutureBuilder<CameraPosition>(
                future: _initCurrentLocation(),
                builder: (BuildContext context,
                        AsyncSnapshot<CameraPosition> cameraPosition) =>
                    StreamBuilder(
                  stream: _fetchMarkersStream(),
                  builder: (BuildContext context,
                          AsyncSnapshot<Set<Marker>> markers) =>
                      cameraPosition.connectionState ==
                                  ConnectionState.waiting ||
                              markers.connectionState == ConnectionState.waiting
                          ? const Center(child: CircularProgressIndicator())
                          : GoogleMap(
                              initialCameraPosition: cameraPosition.data!,
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                              markers: markers.data!,
                            ),
                ),
              ),
            ),
          ),
        ),
      );
}
