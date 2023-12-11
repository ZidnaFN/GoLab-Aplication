import 'package:flutter/material.dart';
import 'package:healtcare/main.dart';
import 'package:healtcare/pages/hasil_page.dart';
import 'package:healtcare/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';


// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    final User? user = Auth().currentUser;

Future<void> signOut() async {
    await Auth().signOut();
     Navigator.pushNamed(context, '/one');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'images/bg.png', // Ganti dengan path gambar latar belakang yang sesuai
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: 200.0,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100.0),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Positioned(
                      top: 50.0, // Sesuaikan dengan posisi vertikal box
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome to GoLab',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Dengan kemudahan dari rumah, Anda dapat melakukan pendaftaran dengan praktis dan efisien. Terima kasih telah mempercayai kami untuk kebutuhan pendaftaran uji lab Anda. Selamat menggunakan layanan kami!',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  CardButton(
                    title: 'Daftar Uji Lab',
                    imageAssetPath:
                        'images/daftar.png', // Ganti dengan path gambar yang sesuai
                    onPressed: ()  {
      // Jika data ditemukan, arahkan ke layar /five
      Navigator.pushNamed(context, '/seventh');
    
  },
                  ),
                  SizedBox(height: 16), // Jarak antara dua card
                  CardButton(
                    title: 'Hasil Uji Lab',
                    imageAssetPath:
                        'images/hasil.png', // Ganti dengan path gambar yang sesuai
                    onPressed: () {
                      Navigator.pushNamed(context, '/third');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        showSelectedLabels: false, // <-- HERE
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                // Handle the button click
                
                signOut();
               
              },
              child: Icon(Icons.logout),
            ),
            label: "Logout",
          ),
        ],
      ),
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  final String title;
  final String imageAssetPath;
  final VoidCallback onPressed;

  const CardButton({
    required this.title,
    required this.imageAssetPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(16.0),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                imageAssetPath,
                height: 80.0, // Sesuaikan tinggi gambar
                width: 80.0, // Sesuaikan lebar gambar
                fit: BoxFit.cover,
              ),
              SizedBox(width: 16.0), // Jarak antara gambar dan teks
              Text(
                title,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
