import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Utility class to launch native map applications (Google Maps/Apple Maps)
/// with specific coordinates or addresses
class MapLauncher {
  /// Launch maps with coordinates and optional label
  static Future<void> openMapsWithCoordinates({
    required double latitude,
    required double longitude,
    String? label,
  }) async {
    if (Platform.isIOS) {
      await _launchAppleMaps(latitude, longitude, label);
    } else {
      await _launchGoogleMaps(latitude, longitude, label);
    }
  }

  /// Launch maps with an address
  static Future<void> openMapsWithAddress(String address) async {
    final encodedAddress = Uri.encodeComponent(address);
    
    if (Platform.isIOS) {
      final url = Uri.parse('http://maps.apple.com/?q=$encodedAddress');
      await _launchUrl(url);
    } else {
      final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$encodedAddress');
      await _launchUrl(url);
    }
  }

  /// Get directions from current location to destination
  static Future<void> getDirections({
    required double destinationLat,
    required double destinationLng,
    String? destinationLabel,
  }) async {
    if (Platform.isIOS) {
      // Apple Maps directions
      final url = Uri.parse(
        'http://maps.apple.com/?daddr=$destinationLat,$destinationLng'
      );
      await _launchUrl(url);
    } else {
      // Google Maps directions
      final url = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$destinationLat,$destinationLng'
      );
      await _launchUrl(url);
    }
  }

  /// Show a bottom sheet with map app options
  static Future<void> showMapOptions({
    required BuildContext context,
    required double latitude,
    required double longitude,
    String? label,
  }) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => MapOptionsSheet(
        latitude: latitude,
        longitude: longitude,
        label: label,
      ),
    );
  }

  // Private helper methods

  static Future<void> _launchAppleMaps(
    double lat,
    double lng,
    String? label,
  ) async {
    final url = label != null
        ? Uri.parse('http://maps.apple.com/?q=${Uri.encodeComponent(label)}&ll=$lat,$lng')
        : Uri.parse('http://maps.apple.com/?ll=$lat,$lng');
    
    await _launchUrl(url);
  }

  static Future<void> _launchGoogleMaps(
    double lat,
    double lng,
    String? label,
  ) async {
    final url = label != null
        ? Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng&query_place_id=${Uri.encodeComponent(label)}')
        : Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    
    await _launchUrl(url);
  }

  static Future<void> _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw Exception('Could not launch $url');
    }
  }
}

/// Bottom sheet widget showing map app options
class MapOptionsSheet extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String? label;

  const MapOptionsSheet({
    super.key,
    required this.latitude,
    required this.longitude,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text(
            'Open in Maps',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (label != null) ...[
            const SizedBox(height: 8),
            Text(
              label!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
          const SizedBox(height: 24),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Platform.isIOS ? Icons.map : Icons.map,
                color: Colors.blue,
              ),
            ),
            title: Text(
              Platform.isIOS ? 'Open in Apple Maps' : 'Open in Google Maps',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: const Text('View location'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.pop(context);
              MapLauncher.openMapsWithCoordinates(
                latitude: latitude,
                longitude: longitude,
                label: label,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.directions,
                color: Colors.green,
              ),
            ),
            title: const Text(
              'Get Directions',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: const Text('Navigate from your location'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.pop(context);
              MapLauncher.getDirections(
                destinationLat: latitude,
                destinationLng: longitude,
                destinationLabel: label,
              );
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

/// Example widget showing how to use MapLauncher with markers
class BookLocationMarker extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String bookTitle;
  final int bookCount;

  const BookLocationMarker({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.bookTitle,
    required this.bookCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBookLocationDetails(context);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 50,
              ),
              Positioned(
                top: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$bookCount',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showBookLocationDetails(BuildContext context) {
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
            padding: const EdgeInsets.all(20),
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
                    const Icon(Icons.book, size: 32, color: Colors.blue),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bookTitle,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            '$bookCount books available',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          MapLauncher.showMapOptions(
                            context: context,
                            latitude: latitude,
                            longitude: longitude,
                            label: bookTitle,
                          );
                        },
                        icon: const Icon(Icons.map),
                        label: const Text('Open in Maps'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          MapLauncher.getDirections(
                            destinationLat: latitude,
                            destinationLng: longitude,
                            destinationLabel: bookTitle,
                          );
                        },
                        icon: const Icon(Icons.directions),
                        label: const Text('Directions'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // View books button
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () {
                      // Navigate to book list
                    },
                    icon: const Icon(Icons.list),
                    label: const Text('View All Books'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
