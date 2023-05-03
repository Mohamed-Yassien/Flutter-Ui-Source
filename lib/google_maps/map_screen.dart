import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_ui_source/google_maps/constant/app_constant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:maps_toolkit/maps_toolkit.dart' as mp;

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final sourceLocation = const LatLng(31.0519265, 31.4044526);

//  final destinationLocation = const LatLng(31.0162202, 31.3761024);

  List<LatLng> polygonCords = const [
    //LatLng(31.0527518, 31.3880721),
    // LatLng(31.06021, 31.3832528),
    LatLng(31.0473393, 31.3780107),
    LatLng(31.0519265, 31.4044526),
    LatLng(31.0210735, 31.4102592),
    LatLng(31.0263399, 31.392298),
    LatLng(31.0414531, 31.3416397),
  ];

  bool isInArea = false;

  checkIfPointInArea(LatLng point) {
    List<mp.LatLng> points = polygonCords
        .map(
          (e) => mp.LatLng(
            e.latitude,
            e.longitude,
          ),
        )
        .toList();

    setState(() {
      isInArea = mp.PolygonUtil.containsLocation(
        mp.LatLng(point.latitude, point.longitude),
        points,
        false,
      );
    });
  }

  Completer<GoogleMapController> mapController = Completer();

  List<LatLng> points = [];

  setUpPolyline() async {
    //await getCurrentLocation();
    PolylinePoints polylinePoints = PolylinePoints();
    final result = await polylinePoints.getRouteBetweenCoordinates(
      AppConstant.mapApiKey,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
    );
    if (result.points.isNotEmpty) {
      for (var element in result.points) {
        points.add(LatLng(element.latitude, element.longitude));
      }
      setState(() {});
    }
  }

  LocationData? currentLocation;

  Future<void> getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    currentLocation = await location.getLocation();
    setState(() {});
    GoogleMapController googleMapController = await mapController.future;
    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13.2,
            target: LatLng(
              newLoc.latitude!,
              newLoc.longitude!,
            ),
          ),
        ),
      );
      checkIfPointInArea(
        LatLng(
          newLoc.latitude!,
          newLoc.longitude!,
        ),
      );
      setState(() {});
    });
  }

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;

  setIcons() {
    // BitmapDescriptor.fromAssetImage(
    //         ImageConfiguration.empty, 'assets/images/loc.png')
    //     .then(
    //   (value) => currentIcon = value,
    // );
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, 'assets/images/loc.png')
        .then(
      (value) => sourceIcon = value,
    );
    setState(() {});
  }

  @override
  void initState() {
    //setUpPolyline();

    setIcons();
    getCurrentLocation().then((value) {
      setUpPolyline();
      checkIfPointInArea(
        LatLng(
          currentLocation!.latitude!,
          currentLocation!.longitude!,
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('google maps'),
      ),
      body: currentLocation == null
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      currentLocation!.latitude!,
                      currentLocation!.longitude!,
                    ),
                    zoom: 13.2,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId(
                        'source',
                      ),
                      position: sourceLocation,
                      icon: sourceIcon,
                    ),
                    Marker(
                        markerId: const MarkerId(
                          'current',
                        ),
                        icon: currentIcon,
                        position: LatLng(
                          currentLocation!.latitude!,
                          currentLocation!.longitude!,
                        ),
                        onDrag: (LatLng po) {
                          checkIfPointInArea(po);
                        }),
                  },
                  // circles: {
                  //   Circle(
                  //     circleId: const CircleId('current'),
                  //     center: LatLng(
                  //       currentLocation!.latitude!,
                  //       currentLocation!.longitude!,
                  //     ),
                  //     radius: 1500,
                  //     strokeWidth: 1,
                  //     fillColor: Colors.red.withOpacity(.4),
                  //     strokeColor: Colors.red,
                  //   )
                  // },
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId('pol'),
                      points: points,
                      color: Colors.red,
                      width: 5,
                    ),
                  },
                  polygons: {
                    Polygon(
                      polygonId: const PolygonId('polygon'),
                      points: polygonCords,
                      strokeWidth: 1,
                      strokeColor: Colors.red,
                      fillColor: Colors.red.withOpacity(.3),
                    ),
                  },
                  onMapCreated: (controller) {
                    mapController.complete(controller);
                  },
                ),
                if (!isInArea)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.red.withOpacity(.7),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(25),
                      child: Text(
                        'No Available Location',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
