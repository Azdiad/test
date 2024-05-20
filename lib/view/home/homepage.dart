import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:university/service/firestore_service.dart';
import 'package:university/view/adddatas/addpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> univercity = ['univercity 1', 'univercity 2'];
  String? _selectedUniversity;
  List<DocumentSnapshot> _userDetails = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Details',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => adddatas(),
              ));
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: DropdownButtonFormField<String>(
              value: _selectedUniversity,
              onChanged: (newValue) {
                setState(() {
                  _selectedUniversity = newValue;
                });
              },
              items: univercity.map((university) {
                return DropdownMenuItem<String>(
                  value: university,
                  child: Text(university),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Select University',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirestoreService().getNotesStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List userdetail = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: userdetail.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = userdetail[index];
                      String docId = document.id;
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      String name = data['name'] ?? '';
                      String dob = data['dob'] ?? '';
                      String subjects = data['subject'] ?? '';
                      String university = data['university'] ?? '';

                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            color: Colors.blue[300],
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      FirestoreService().deletion(docId);
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                  Center(
                                    child: Text(
                                      'Name : $name',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Text('DOB : $dob'),
                                  Text(
                                    'University : $university',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    'Subjects : ${subjects}',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
