import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/location_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();

  final List<LocationModel> locations = [
    LocationModel(
      name: 'Medika Satwa Pet Shop & Pet Clinic',
      description: 'Pet Shop Lembang & Dokter Hewan Lembang',
      category: 'Kucing',
      latitude: -6.818107513864515,
      longitude: 107.6236430161554,
      imageIcon: '😸',
    ),
    LocationModel(
      name: 'GERLONG Aquarium',
      description: 'GERLONG Aquarium',
      category: 'Ikan',
      latitude: -6.868920544130081,
      longitude: 107.58825423675081,
      imageIcon: '🐟',
    ),
    LocationModel(
      name: 'Pet Kingdom Ciwalk',
      description: 'Toko Perlengkapan Hewan Peliharaan',
      category: 'Anjing',
      latitude: -6.89294384037168,
      longitude: 107.60575786655703,
      imageIcon: '🐕',
    ),
    LocationModel(
      name: 'Torto Mania',
      description: 'Tortoise & Reptile shop',
      category: 'Reptil',
      latitude: -6.952854944393578,
      longitude: 107.60599341154301,
      imageIcon: '🐢',
    ),
    LocationModel(
      name: 'Toko Kelinci Ari Rabbit',
      description: 'Toko kelinci',
      category: 'Kelinci',
      latitude: -6.839675137427055,
      longitude: 107.59770329364109,
      imageIcon: '🐇',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Lokasi'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              _mapController.move(
                const LatLng(-6.90068233920046, 107.61834300249537),
                11,
              );
            },
            tooltip: 'Reset ke lokasi awal',
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialCenter: LatLng(-6.90068233920046, 107.61834300249537),
              initialZoom: 11,
              minZoom: 5,
              maxZoom: 18,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.uts',
              ),
              MarkerLayer(
                markers: locations.map((location) {
                  return Marker(
                    point: LatLng(location.latitude, location.longitude),
                    width: 80,
                    height: 80,
                    child: GestureDetector(
                      onTap: () {
                        _showLocationInfo(location);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              location.imageIcon,
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                          const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 32,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'zoom_in',
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    _mapController.move(
                      _mapController.camera.center,
                      _mapController.camera.zoom + 1,
                    );
                  },
                  child: const Icon(Icons.add, color: Colors.deepPurple),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'zoom_out',
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    _mapController.move(
                      _mapController.camera.center,
                      _mapController.camera.zoom - 1,
                    );
                  },
                  child: const Icon(Icons.remove, color: Colors.deepPurple),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLocationInfo(LocationModel location) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    location.imageIcon,
                    style: const TextStyle(fontSize: 48),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            location.category,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.deepPurple[900],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                location.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    '${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _mapController.move(
                      LatLng(location.latitude, location.longitude),
                      15,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(Icons.navigation),
                  label: const Text('Lihat di Peta'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
