import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference donor = FirebaseFirestore.instance.collection('doner');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CONTACTS APP"),
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,size: 40,),
        onPressed: (){
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,

      body: StreamBuilder(
        stream: donor.orderBy('name').snapshots(),
        builder:(context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                final DocumentSnapshot donerSnap = snapshot.data.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 80,
                     // color: Colors.white,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                          boxShadow: [BoxShadow(color: Colors.grey.shade400,
                          blurRadius: 10,
                            spreadRadius: 15,
                          ),]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 30,
                                child: Text(donerSnap['group'],style: TextStyle(fontSize: 25),),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(donerSnap['name'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                              Text(donerSnap['phone'].toString(),style: TextStyle(fontSize: 14))
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(onPressed: (){
                                Navigator.pushNamed(context, '/update',arguments: {
                                  'name' : donerSnap['name'],
                                  'phone' : donerSnap['phone'],
                                  'group' : donerSnap['group'],
                                  'id' : donerSnap.id
                                });

                              }, icon: Icon(Icons.edit),iconSize: 30,color: Colors.blue,),
                              IconButton(onPressed: (){
                                deleteDonor(donerSnap.id);
                              }, icon: Icon(Icons.delete),iconSize: 30,color: Colors.red,)
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
            );
          }
          return Container();
        },
      ),
    );
  }

  void deleteDonor(String id) {
    donor.doc(id).delete();
  }
}
