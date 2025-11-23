import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wander/features/home/global_stats.dart';

class MapViewGoogle extends StatefulWidget {
  const MapViewGoogle({super.key});

  @override
  State<MapViewGoogle> createState() => _MapViewGoogleState();
}

class _MapViewGoogleState extends State<MapViewGoogle> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  final LatLng _initialPosition = const LatLng(37.7749, -122.4194); // San Francisco
  MapType _currentMapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    _addSampleMarkers();
  }

  void _addSampleMarkers() {
    // Add some sample book locations
    _markers.addAll([
      Marker(
        markerId: const MarkerId('location1'),
        position: const LatLng(37.7749, -122.4194),
        infoWindow: const InfoWindow(
          title: 'San Francisco',
          snippet: '15 books shared',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        onTap: () => _onMarkerTapped('San Francisco'),
      ),
      Marker(
        markerId: const MarkerId('location2'),
        position: const LatLng(40.7128, -74.0060),
        infoWindow: const InfoWindow(
          title: 'New York',
          snippet: '23 books shared',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        onTap: () => _onMarkerTapped('New York'),
      ),
      Marker(
        markerId: const MarkerId('location3'),
        position: const LatLng(51.5074, -0.1278),
        infoWindow: const InfoWindow(
          title: 'London',
          snippet: '18 books shared',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        onTap: () => _onMarkerTapped('London'),
      ),
    ]);
  }

  void _onMarkerTapped(String location) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              location,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text('Books available at this location'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate to location details
              },
              child: const Text('View Books'),
            ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _toggleMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _goToMyLocation() {
    // In a real app, get user's actual location
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(_initialPosition, 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WanderBooks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _showSearchDialog();
            },
          ),
          IconButton(
            icon: const Icon(Icons.layers),
            onPressed: _toggleMapType,
            tooltip: 'Toggle map type',
          ),
        ],
      ),
      body: Column(
        children: [
          const GlobalStatsCard(),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 3,
                  ),
                  markers: _markers,
                  mapType: _currentMapType,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  compassEnabled: true,
                  mapToolbarEnabled: false,
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        heroTag: 'location',
                        mini: true,
                        onPressed: _goToMyLocation,
                        child: const Icon(Icons.my_location),
                      ),
                      const SizedBox(height: 8),
                      FloatingActionButton(
                        heroTag: 'add',
                        mini: true,
                        onPressed: () {
                          // Add new book location
                          _showAddLocationDialog();
                        },
                        child: const Icon(Icons.add_location),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Location'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: 'Enter city or address',
            prefixIcon: Icon(Icons.search),
          ),
          onSubmitted: (value) {
            Navigator.pop(context);
            // Implement geocoding to search location
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showAddLocationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Book Location'),
        content: const Text('Tap on the map to select a location where you want to share a book.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
