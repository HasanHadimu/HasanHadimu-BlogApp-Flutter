import 'package:flutter/material.dart';
import 'package:personalportofolio/screen/login.dart';
import 'package:personalportofolio/screen/post_form.dart'; // Impor PostForm

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0; // Index tab yang sedang aktif

  // Fungsi logout untuk navigasi ke halaman login
  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  // List data untuk menampilkan 10 blog
  final List<Map<String, String>> _blogData = List.generate(
    10,
    (index) => {
      'image':
          'https://picsum.photos/250?image=1', // Ganti dengan URL gambar yang valid
      'description': 'Deskripsi blog ke-$index', // Deskripsi untuk setiap blog
    },
  );

  // Fungsi untuk mengubah tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Navigasi ke PostForm saat tab "Tambah Post" dipilih
      if (_selectedIndex == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const PostForm()), // Navigasi ke halaman PostForm
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _logout, // Panggil fungsi logout
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _selectedIndex == 1
          ? const Center(child: Text('Menambahkan Post...')) // Placeholder
          : _selectedIndex == 0
              ? ListView.builder(
                  itemCount: _blogData.length, // Menampilkan 10 blog
                  itemBuilder: (context, index) {
                    return BlogCard(
                      imageUrl: _blogData[index]['image']!,
                      description: _blogData[index]['description']!,
                    );
                  },
                ) // Menampilkan daftar blog pada tab "Home"
              : Center(
                  child: Text(
                    'Halaman Profil User',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ), // Tab lainnya
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Tambah Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex, // Tab yang sedang aktif
        selectedItemColor: Colors.blue, // Warna tab aktif
        onTap: _onItemTapped, // Ubah tab saat di-tap
      ),
    );
  }
}

class BlogCard extends StatelessWidget {
  final String imageUrl;
  final String description;

  const BlogCard({
    required this.imageUrl,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar blog
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          // Deskripsi blog
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
