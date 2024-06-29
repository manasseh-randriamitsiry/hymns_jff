/**
    import 'package:flutter/material.dart';
    import 'package:flutter_map/flutter_map.dart';
    import 'package:latlong2/latlong.dart';

    class LocationPickerScreen extends StatefulWidget {
    @override
    _LocationPickerScreenState createState() => _LocationPickerScreenState();
    }

    class _LocationPickerScreenState extends State<LocationPickerScreen> {
    LatLng? _selectedLocation;

    @override
    Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: Text('Pick a Location'),
    actions: [
    IconButton(
    icon: Icon(Icons.check),
    onPressed: () {
    if (_selectedLocation != null) {
    // Return the selected location
    Navigator.pop(context, _selectedLocation);
    } else {
    // Show an error if no location is selected
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('No location selected!')),
    );
    }
    },
    ),
    ],
    ),
    body: FlutterMap(
    options: MapOptions(
    center: LatLng(37.7749, -122.4194), // Initial center
    zoom: 13.0,
    onTap: (tapPosition, point) {
    setState(() {
    _selectedLocation = point;
    });
    },
    ),
    layers: [_
    TileLayerOptions(
    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
    subdomains: ['a', 'b', 'c'],
    attributionBuilder: (_) {
    return Text("© OpenStreetMap contributors");
    },
    ),
    if (_selectedLocation != null)
    MarkerLayerOptions(
    markers: [
    Marker(
    width: 80.0,
    height: 80.0,
    point: _selectedLocation!,
    builder: (ctx) =>
    Icon(Icons.location_on, color: Colors.red, size: 40.0),
    ),
    ],
    ),
    ],
    ),
    );
    }
    }
 **/
