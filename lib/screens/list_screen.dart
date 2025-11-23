import 'package:flutter/material.dart';
import '../models/location_model.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
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

  String _searchQuery = '';
  String _selectedCategory = 'Semua';

  List<String> get categories {
    final cats = locations.map((e) => e.category).toSet().toList();
    cats.insert(0, 'Semua');
    return cats;
  }

  List<LocationModel> get filteredLocations {
    return locations.where((location) {
      final matchesSearch = location.name
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          location.description
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == 'Semua' || location.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pet Shop'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari pet shop...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories.map((category) {
                      final isSelected = _selectedCategory == category;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                          selectedColor: Colors.deepPurple,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredLocations.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Pet shop tidak ditemukan',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredLocations.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final location = filteredLocations[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.deepPurple[50],
                            child: Text(
                              location.imageIcon,
                              style: const TextStyle(fontSize: 28),
                            ),
                          ),
                          title: Text(
                            location.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(location.description),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
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
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(location.name),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(location.description),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Kategori: ${location.category}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Koordinat:',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('Lat: ${location.latitude}'),
                                    Text('Long: ${location.longitude}'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Tutup'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
