import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Struk extends StatefulWidget {
  const Struk({Key? key}) : super(key: key);

  @override
  State<Struk> createState() => _StrukState();
}

class _StrukState extends State<Struk> {
  late String? emailU;
  late User loggedInUser;

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

  final CollectionReference _healthcare =
      FirebaseFirestore.instance.collection('healthcare');
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Struk Pendaftaran Uji Lab"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Tambahkan logika kembali di sini
              Navigator.pushNamed(context, '/');
            },
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('healthcare')
            .where('email', isEqualTo: emailU)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

          return Center(
            child: Container(
              margin: EdgeInsets.all(16),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 30,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              '$antrian',
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Nama: $nama',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'NIK: $nik',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Rincian:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Alamat: $alamat',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Jenis Kelamin: $jenisKelamin',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Jenis Pengujian: $jenisPengujian',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Tanggal Pengujian: $tPengujian',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Waktu Pendaftaran: -',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 50,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Rp342.000',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Cetak Struk'),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   unselectedItemColor: Colors.white,
      //   selectedItemColor: Colors.white,
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   backgroundColor: Colors.blue,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: "Button 1",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: InkWell(
      //         onTap: () {
      //           // Handle the button click
      //           Navigator.pushNamed(context, '/');
      //         },
      //         child: Icon(Icons.logout),
      //       ),
      //       label: "Logout",
      //     ),
      //   ],
      // ),
    );
  }
}
