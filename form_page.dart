import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:developer';
import 'package:healtcare/pages/hasil_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

// void main() {
//   runApp(const FormInput());
// }

// class FormInput extends StatelessWidget {
//   const FormInput({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MyForm(),
//     );
//   }
// }

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  late String emailU;
  late String nama;
  late String alamat;
  late String nik;
  late String ttl;
  late String tPengujian;
  late String jenisKelamin;
  late String jenisPengujian;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _jkController = TextEditingController();
  final TextEditingController _jpController = TextEditingController();

  late DateTime pickedDate;
  late DateTime pickedDate2;

  final CollectionReference _healthcare = FirebaseFirestore.instance.collection('healthcare');
   final _auth = FirebaseAuth.instance;
     late User loggedInUser;

  String selectedValue = 'Laki-Laki';
  List<String> dropdownItems = ['Laki-Laki', 'Perempuan'];

  String selectedValue1 = 'Darah';
  List<String> dropdownItems1 = ['Darah', 'Urine', 'Feses'];

  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    // String action = 'create';
    // if (documentSnapshot != null) {
    //   action = 'update';
    //   _nameController.text = documentSnapshot['nama'];
    //   _alamatController.text = documentSnapshot['alamat'];
    //   _nikController.text = documentSnapshot['nik'];
    //   _tanggalController.text = documentSnapshot['tanggal'];
    //   _jkController.text = documentSnapshot['jenisKelamin'];
    //   _jpController.text = documentSnapshot['jenisPengujian'];
    // }
    
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        pickedDate=selectedDate;
        ttl=pickedDate.toString();
      });
    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? picked2 = await showDatePicker(
      context: context,
      initialDate: selectedDate2,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      
    );

    if (picked2 != null && picked2 != selectedDate2) {
      setState(() {
        selectedDate2 = picked2;
        pickedDate2=selectedDate2;
        tPengujian=pickedDate2.toString();
      });
    }
  }

   void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        emailU=(loggedInUser.email).toString();
      }
    } catch (e) {
      print(e);
    }
  }
  

  void _submitForm([DocumentSnapshot? documentSnapshot]) async {
    Navigator.pushNamed(context, '/sixth');
    // Logika untuk mengirim formulir atau melakukan tindakan lainnya
    //String action = 'create';
    if (documentSnapshot != null) {
      //action = 'update';
      _nameController.text = documentSnapshot['nama'];
      _alamatController.text = documentSnapshot['alamat'];
      _nikController.text = documentSnapshot['nik'];
      _tanggalController.text = documentSnapshot['tanggal'];
      _jkController.text = documentSnapshot['jenisKelamin'];
      _jpController.text = documentSnapshot['jenisPengujian'];
    }
    final _fireStore = FirebaseFirestore.instance;
    int count = await FirebaseFirestore.instance.collection('healthcare').where('tanggalPengujian', isEqualTo: tPengujian).get().then((value) => value.size);
debugPrint(count.toString());
int antrian=count+1;
getCurrentUser();
_fireStore.collection('healthcare').add({
  'nama': nama,
  'alamat':alamat,
  'nik':nik,
  'ttl':ttl,
  'jenisKelamin': jenisKelamin,
  'jenisPengujian': jenisPengujian,
  'tanggalPengujian':tPengujian,
  'antrian':antrian,
  'email':emailU,


  
  // 'task': task,
  // 'place': place,
  // 'time': time,
});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pendaftaran Uji Lab"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Tambahkan logika kembali di sini
              Navigator.pushNamed(context, '/');
            },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Nama'),
                           onChanged: (value) {
                  nama = value;
                },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _alamatController,
                      
                        decoration: InputDecoration(labelText: 'Alamat'),
                                 onChanged: (value) {
                  alamat = value;
                },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _nikController,
                        
                        decoration: InputDecoration(labelText: 'NIK'),
                              onChanged: (value) {
                  nik = value;
                },
                      ),
                      SizedBox(height: 16.0),
                      Text(
            
                        'Tanggal Lahir: ${selectedDate.toLocal()}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Select Date'),
                      ),
                      SizedBox(height: 16.0),
                      // DropdownButtonFormField<String>(
                      //   value: jenisKelamin,
                      //   onChanged: (newValue) {
                      //     setState(() {
                      //       jenisKelamin = newValue!;
                      //     });
                      //   },
                      //   items: ['Laki - Laki', 'Perempuan']
                      //       .map<DropdownMenuItem<String>>((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      //   decoration: InputDecoration(
                      //     labelText: 'Jenis Kelamin',
                      //   ),
                      // ),
                      Text(
    
                        'Jenis Kelamin:',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      DropdownButton<String>(
                        value: selectedValue,
                      
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                            jenisKelamin=selectedValue;
                            
                          });
                        },
                        items: dropdownItems
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Jenis Pengujian:',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      DropdownButton<String>(
                        value: selectedValue1,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue1 = newValue!;
                            jenisPengujian=selectedValue1;
                          });
                        },
                        items: dropdownItems1
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      Text(
            
                        'Tanggal Pemeriksaan: ${selectedDate2.toLocal()}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      ElevatedButton(
                        onPressed: () => _selectDate2(context),
                        child: Text('Select Date'),
                      ),
                      SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.0),
              child: ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.blue,
      //   unselectedItemColor: Colors.white,
      //   selectedItemColor: Colors.white,
      //   showSelectedLabels: false, // <-- HERE
      //   showUnselectedLabels: false,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.home,
      //       ),
      //       label: "Home",
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
