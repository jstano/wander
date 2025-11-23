import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:wander/features/home/global_stats.dart';

/// Alternative map implementation using OpenStreetMap (no API key required)
class MapViewOpenStreet extends StatefulWidget {
  const MapViewOpenStreet({super.key});

  @override
  State<MapViewOpenStreet> createState() => _MapViewOpenStreetState();
}

class _MapViewOpenStreetState extends State<MapViewOpenStreet> {
  final MapController _mapController = MapController();
  final List<Marker> _markers = [];
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _addSampleMarkers();
  }

  void _addSampleMarkers() {
    _markers.addAll([
      Marker(
        point: LatLng(37.7749, -122.4194),
        width: 80,
        height: 80,
        child: GestureDetector(
          onTap: () => _showLocationDetails('San Francisco', 15),
          child: const Column(
            children: [
              Icon(Icons.location_on, color: Colors.red, size: 40),
              Text('SF', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
      Marker(
        point: LatLng(40.7128, -74.0060),
        width: 80,
        height: 80,
        child: GestureDetector(
          onTap: () => _showLocationDetails('New York', 23),
          child: const Column(
            children: [
              Icon(Icons.location_on, color: Colors.red, size: 40),
              Text('NYC', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
      Marker(
        point: LatLng(51.5074, -0.1278),
        width: 80,
        height: 80,
        child: GestureDetector(
          onTap: () => _showLocationDetails('London', 18),
          child: const Column(
            children: [
              Icon(Icons.location_on, color: Colors.red, size: 40),
              Text('LON', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
      Marker(
        point: LatLng(48.8566, 2.3522),
        width: 80,
        height: 80,
        child: GestureDetector(
          onTap: () => _showLocationDetails('Paris', 12),
          child: const Column(
            children: [
              Icon(Icons.location_on, color: Colors.red, size: 40),
              Text('PAR', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
      Marker(
        point: LatLng(35.6762, 139.6503),
        width: 80,
        height: 80,
        child: GestureDetector(
          onTap: () => _showLocationDetails('Tokyo', 31),
          child: const Column(
            children: [
              Icon(Icons.location_on, color: Colors.red, size: 40),
              Text('TYO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    ]);
  }

  void _showLocationDetails(String city, int bookCount) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.8,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_city, size: 32, color: Colors.blue),
                    const SizedBox(width: 12),
                    Text(
                      city,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.book, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        '$bookCount books available',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Popular Books:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...List.generate(
                  3,
                  (index) => ListTile(
                    leading: const Icon(Icons.menu_book),
                    title: Text('Book Title ${index + 1}'),
                    subtitle: const Text('Genre • Author Name'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Navigate to book details
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigate to full list
                    },
                    icon: const Icon(Icons.list),
                    label: const Text('View All Books'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _goToLocation(LatLng location) {
    _mapController.move(location, 13);
  }

  void _zoomIn() {
    final currentZoom = _mapController.camera.zoom;
    _mapController.move(_mapController.camera.center, currentZoom + 1);
  }

  void _zoomOut() {
    final currentZoom = _mapController.camera.zoom;
    _mapController.move(_mapController.camera.center, currentZoom - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WanderBooks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearchDialog,
          ),
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const GlobalStatsCard(),
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: LatLng(37.7749, -122.4194),
                    initialZoom: 3,
                    minZoom: 2,
                    maxZoom: 18,
                    onTap: (tapPosition, point) {
                      // Handle map tap
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: _isDarkMode
                          ? 'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png'
                          : 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                      userAgentPackageName: 'com.example.wander',
                    ),
                    MarkerLayer(markers: _markers),
                  ],
                ),
                // Zoom controls
                Positioned(
                  bottom: 100,
                  right: 16,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        heroTag: 'zoom_in',
                        mini: true,
                        onPressed: _zoomIn,
                        child: const Icon(Icons.add),
                      ),
                      const SizedBox(height: 8),
                      FloatingActionButton(
                        heroTag: 'zoom_out',
                        mini: true,
                        onPressed: _zoomOut,
                        child: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                ),
                // Location shortcuts
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    heroTag: 'my_location',
                    onPressed: () {
                      // Go to user location
                      _goToLocation(LatLng(37.7749, -122.4194));
                    },
                    child: const Icon(Icons.my_location),
                  ),
                ),
                // Quick location buttons
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildLocationChip('San Francisco', LatLng(37.7749, -122.4194)),
                        _buildLocationChip('New York', LatLng(40.7128, -74.0060)),
                        _buildLocationChip('London', LatLng(51.5074, -0.1278)),
                        _buildLocationChip('Paris', LatLng(48.8566, 2.3522)),
                        _buildLocationChip('Tokyo', LatLng(35.6762, 139.6503)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddLocationDialog,
        icon: const Icon(Icons.add_location),
        label: const Text('Add Book'),
      ),
    );
  }

  Widget _buildLocationChip(String name, LatLng location) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        avatar: const Icon(Icons.location_on, size: 18),
        label: Text(name),
        onPressed: () => _goToLocation(location),
        backgroundColor: Colors.white,
        elevation: 4,
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
            hintText: 'Enter city name',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            Navigator.pop(context);
            // Implement search logic
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Searching for: $value')),
            );
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
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Share a book with the WanderBooks community!'),
            SizedBox(height: 16),
            Text(
              'Tap on the map or use your current location to mark where you\'re leaving a book.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to add book form
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
