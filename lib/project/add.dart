import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final CollectionReference donor = FirebaseFirestore.instance.collection('doner');
  final List<String> bloodgroup = ["A","A+","B","B+","O+","O-","AB+","AB-"];
  String? selectedGroup;
  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();

  void addDonor(){
    final data = {'name' : donorName.text, 'phone' : donorPhone.text, 'group' : selectedGroup};
    donor.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD USERS"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: donorName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Donner Name :")
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: donorPhone,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Phone Number :")
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  label: Text("Select Blood Group :")
                ),
                  items: bloodgroup.map((e) => DropdownMenuItem(
                    value: e,
                      child: Text(e))).toList(),
                  onChanged: (val){selectedGroup = val;}
              ),
            ),

            ElevatedButton(
                onPressed: (){
                  addDonor();
                  Navigator.pop(context);
                },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(double.infinity,50)),
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
                child: Text("Submit",style: TextStyle(fontSize: 20),),
            )

          ],
        ),
      ),
    );
  }
}
