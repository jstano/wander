# OpenStreetMap Setup Guide (No API Key Required!)

## Advantages
- ✅ **No API key needed**
- ✅ Free and open source
- ✅ No usage limits
- ✅ Lightweight
- ✅ Easy to customize

## Step 1: Add Dependencies

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_map: ^6.1.0
  latlong2: ^0.9.0
  geolocator: ^10.1.0  # Optional: for user location
```

Run: `flutter pub get`

## Step 2: Configure Permissions (Optional - for location features)

### Android (android/app/src/main/AndroidManifest.xml)

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

### iOS (ios/Runner/Info.plist)

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location to show nearby books.</string>
```

## Step 3: Use the Map

Replace your MapView with the OpenStreetMap version:

```dart
import 'package:wander/features/map/map_view_openstreet.dart';

// In your navigation or main widget
MapViewOpenStreet()
```

## Features Included

✅ Interactive map with custom markers
✅ Dark mode support
✅ Zoom controls
✅ Location search
✅ Quick city navigation chips
✅ Detailed location bottom sheets
✅ Add book location functionality
✅ Tap-to-view location details

## Available Map Styles

### Light Mode (default)
- OpenStreetMap Standard: `https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png`

### Dark Mode
- Stadia Dark: `https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png`

### Other Options (change urlTemplate in TileLayer):

```dart
// Satellite view
'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}'

// Watercolor (artistic)
'https://tiles.stadiamaps.com/tiles/stamen_watercolor/{z}/{x}/{y}.jpg'

// Terrain
'https://tiles.stadiamaps.com/tiles/stamen_terrain/{z}/{x}/{y}{r}.png'
```

## Customization Examples

### Custom Marker Icons

```dart
Marker(
  point: LatLng(37.7749, -122.4194),
  width: 80,
  height: 80,
  child: GestureDetector(
    onTap: () => _showLocationDetails('San Francisco', 15),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.location_on, color: Colors.red, size: 50),
        Positioned(
          top: 10,
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Text('15', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    ),
  ),
)
```

### Add Polylines (routes between locations)

```dart
FlutterMap(
  children: [
    TileLayer(/* ... */),
    PolylineLayer(
      polylines: [
        Polyline(
          points: [
            LatLng(37.7749, -122.4194),
            LatLng(40.7128, -74.0060),
          ],
          color: Colors.blue,
          strokeWidth: 3,
        ),
      ],
    ),
    MarkerLayer(markers: _markers),
  ],
)
```

### Add Circle Overlays

```dart
CircleLayer(
  circles: [
    CircleMarker(
      point: LatLng(37.7749, -122.4194),
      radius: 5000, // meters
      color: Colors.blue.withOpacity(0.3),
      borderColor: Colors.blue,
      borderStrokeWidth: 2,
    ),
  ],
)
```

## Performance Tips

1. **Limit markers**: Use clustering for many markers
2. **Cache tiles**: Configure tile caching for offline use
3. **Optimize rebuilds**: Use `const` constructors where possible
4. **Lazy loading**: Load markers progressively as map moves

## Next Steps

1. Connect to your book database
2. Implement real-time updates
3. Add marker clustering (use flutter_map_marker_cluster)
4. Implement geocoding for address search
5. Add offline map support
6. Customize marker icons based on book categories

## Comparison: Google Maps vs OpenStreetMap

| Feature | Google Maps | OpenStreetMap |
|---------|-------------|---------------|
| API Key | Required | Not Required |
| Cost | Usage limits/billing | Free |
| Customization | Limited | Extensive |
| Setup | More complex | Simple |
| Community | Large | Large |
| Best For | Production apps with budget | Quick prototypes, free apps |

## Recommendation

- **Start with OpenStreetMap** for development and testing
- **Switch to Google Maps** if you need specific features or better satellite imagery
- Both implementations are provided - easy to switch!
