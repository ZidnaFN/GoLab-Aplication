import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Hasil extends StatefulWidget {
  const Hasil({Key? key}) : super(key: key);

  @override
  State<Hasil> createState() => _HasilState();
}

class _HasilState extends State<Hasil> {
  String imageUrl = '';
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  late String emailU;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        emailU = (loggedInUser.email).toString();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getImageUrl(String imageUrlRef) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(imageUrlRef);
      // no need for the file extension, the name will do fine.
      var url = await ref.getDownloadURL();
      debugPrint(url);
      setState(() {
        imageUrl = url;
      });
    } catch (e) {
      print('Error fetching image URL: $e');
      // Handle the error gracefully, such as showing a placeholder image or message
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hasil Lab'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('healthcare')
              .where('email', isEqualTo: emailU)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            if (snapshot.data!.docs.isEmpty) {
              return Text('Dokumen tidak ditemukan.');
            }

            DocumentSnapshot documentSnapshot = snapshot.data!.docs[0];

            String? nama = documentSnapshot['nama'];
            String? alamat = documentSnapshot['alamat'];
            String? nik = documentSnapshot['nik'];
            String? ttl = documentSnapshot['ttl'];
            String? jenisKelamin = documentSnapshot['jenisKelamin'];
            String? jenisPengujian = documentSnapshot['jenisPengujian'];
            String? tPengujian = documentSnapshot['tanggalPengujian'];
            int? antrian = documentSnapshot['antrian'];
           
            String imageUrlGet=documentSnapshot['hasil'];
            getImageUrl(imageUrlGet);
          

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset("images/hasil.png"),
                  Image(image: NetworkImage(imageUrl)),
                  // Display other information if needed
                 
                ],
              ),
            );
          },
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   backgroundColor: Colors.blue,
        //   unselectedItemColor: Colors.white,
        //   selectedItemColor: Colors.white,
        //   showSelectedLabels: false,
        //   showUnselectedLabels: false,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: InkWell(
        //         onTap: () {
        //           Navigator.pushNamed(context, '/second');
        //         },
        //         child: Icon(Icons.logout),
        //       ),
        //       label: "Home",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: InkWell(
        //         onTap: () {
        //           Navigator.pushNamed(context, '/');
        //         },
        //         child: Icon(Icons.logout),
        //       ),
        //       label: "Logout",
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
