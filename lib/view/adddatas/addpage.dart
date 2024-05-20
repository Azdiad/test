import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:university/service/firestore_service.dart';
import 'package:university/view/home/homepage.dart';

class adddatas extends StatefulWidget {
  adddatas({Key? key}) : super(key: key);

  @override
  State<adddatas> createState() => _adddatasState();
}

class _adddatasState extends State<adddatas> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController monthcontroller = TextEditingController();
  TextEditingController yearcontroller = TextEditingController();
  List<String> subjects = ['subject 1 ', 'subject 2 '];
  List<String> univercity = ['univercity 1', 'univercity 2'];
  List<String> _selectedSub = [];
  String? _selectedUnivercity;
  String? dob;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Homepage(),
                      ));
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  Text(
                    'Fill Datas',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(),
                ],
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: namecontroller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusColor: Colors.grey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          hintText: 'Enter Name ',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text('Enter DOB : '),
                          ),
                          SizedBox(
                            width: 60,
                            child: TextFormField(
                              controller: datecontroller,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(2),
                              ],
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusColor: Colors.grey,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                hintText: 'DD',
                              ),
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                if (value.length == 2) node.nextFocus();
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Date';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 30),
                          SizedBox(
                            width: 60,
                            child: TextFormField(
                              controller: monthcontroller,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(2),
                              ],
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusColor: Colors.grey,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                hintText: 'MM',
                              ),
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                if (value.length == 2) node.nextFocus();
                                if (value.length <= 0) node.previousFocus();
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Month';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 30),
                          SizedBox(
                            width: 70,
                            child: TextFormField(
                              controller: yearcontroller,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(4),
                              ],
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusColor: Colors.grey,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                hintText: 'YY',
                              ),
                              textInputAction: TextInputAction.done,
                              onChanged: (value) {
                                if (value.length <= 0) node.previousFocus();
                                log("${datecontroller.text}/${monthcontroller.text}/${yearcontroller.text}");
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Year';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Select Subjects',
                                border: OutlineInputBorder(),
                              ),
                              value: null,
                              onChanged: (newValue) {
                                setState(() {
                                  if (_selectedSub.contains(newValue)) {
                                    _selectedSub.remove(newValue);
                                  } else {
                                    _selectedSub.add(newValue!);
                                  }
                                });
                              },
                              items: subjects.map((subject) {
                                return DropdownMenuItem<String>(
                                  value: subject,
                                  child: Text(subject),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      if (_selectedSub.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selected Subjects:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Wrap(
                              children: _selectedSub.map((subject) {
                                log(_selectedSub.join('').toString());
                                return Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Chip(label: Text(subject)),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Select University',
                                border: OutlineInputBorder(),
                              ),
                              value: _selectedUnivercity,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedUnivercity = newValue;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select university';
                                }
                                return null;
                              },
                              items: univercity.map((univercityy) {
                                return DropdownMenuItem<String>(
                                  value: univercityy,
                                  child: Text(univercityy),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      if (_selectedUnivercity?.isEmpty == false)
                        Text(
                          ' University :  $_selectedUnivercity',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                child: FloatingActionButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String dob =
                          "${datecontroller.text}/${monthcontroller.text}/${yearcontroller.text}";
                      FirestoreService().addnotes(
                          name: namecontroller.text,
                          dob: dob!,
                          subjects: _selectedSub
                              .join(
                                ', ',
                              )
                              .toString(),
                          univercity: _selectedUnivercity.toString());

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Homepage(),
                      ));
                    }
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
