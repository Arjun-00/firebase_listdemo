import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final CollectionReference donor = FirebaseFirestore.instance.collection('doner');
  final List<String> bloodgroup = ["A","A+","B","B+","O+","O-","AB+","AB-"];
  String? selectedGroup;
  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    donorName.text = args['name'];
    donorPhone.text = args['phone'].toString();
    selectedGroup = args['group'];
    final docId = args['id'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("UPDATE USERS"),
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
                value: selectedGroup,
                  decoration: const InputDecoration(
                      label: Text("Select Blood Group :")
                  ),
                  items: bloodgroup.map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e))).toList(),
                  onChanged: (val){selectedGroup = val as String?;}
              ),
            ),

            ElevatedButton(
              onPressed: (){
                updateDonor(docId);
               // Navigator.pop(context);
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(double.infinity,50)),
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: Text("Update",style: TextStyle(fontSize: 20),),
            )

          ],
        ),
      ),
    );
  }

  void updateDonor(docId) {
    final data = {
      'name' : donorName.text,
      'phone' : donorPhone.text,
      'group' : selectedGroup
    };
    donor.doc(docId).update(data).then((value) => Navigator.pop(context));
  }
}
