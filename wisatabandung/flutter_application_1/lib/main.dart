import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pilih Negara',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CountrySelectionScreen(),
    );
  }
}

class CountrySelectionScreen extends StatelessWidget {
  // Daftar negara dengan bendera
  final List<Map<String, String>> countries = [
    {'name': 'Indonesia', 'flag': 'assets/indonesia.png'},
    {'name': 'Malaysia', 'flag': 'assets/malaysia.png'},
    {'name': 'Singapura', 'flag': 'assets/singapore.png'},
    {'name': 'Thailand', 'flag': 'assets/thailand.png'},
    {'name': 'Vietnam', 'flag': 'assets/vietnam.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Negara'),
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 4,
            child: InkWell(
              onTap: () {
                // Tampilkan Snackbar ketika negara dipilih
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Anda memilih: ${countries[index]['name']}'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(
                  8), // Ripple effect dengan border radius
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Image.asset(
                      countries[index]['flag']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 16), // Jarak antara gambar dan teks
                    Text(
                      countries[index]['name']!,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
