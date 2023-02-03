import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/itemlist_Display.dart';
import 'bestCard.dart';

class BestScreen extends StatefulWidget {
  const BestScreen({Key? key}) : super(key: key);

  @override
  State<BestScreen> createState() => _BestScreenState();
}

class _BestScreenState extends State<BestScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  dumm dum = dumm();
  List<Object> _itemlist = [];
  @override
  void initState() {
    super.initState();
    getItemList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow[100],
      padding: const EdgeInsets.all(20),
      //width: 200,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _itemlist.length,
          itemBuilder: (context, index) {
            final item = _itemlist[index];
            return BestCard(item as dumm);
          } //=> build(context),
          ),
    );
  }

  Future getItemList() async {
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection('Items')
        .orderBy('profits', descending: true)
        .get();
    setState(() {
      _itemlist = List.from(data.docs.map((doc) => dumm.fromSnapshot(doc)));
    });
  }
}
