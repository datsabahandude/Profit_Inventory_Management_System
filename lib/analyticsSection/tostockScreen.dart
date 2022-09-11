import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummytest/analyticsSection/stockCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/itemlist_Display.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  dumm dum = dumm();
  List<Object> _itemlist = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItemList();
  }
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow[200],
      padding: EdgeInsets.all(20),
      //width: 200,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _itemlist.length,
          itemBuilder: (context, index) {
            final item = _itemlist[index];
            return StockCard(_itemlist[index] as dumm);
          } //=> build(context),
      ),
    );
  }
  Future getItemList() async{
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection('Items')
        .orderBy('sold', descending: true)
        .get();
    setState(() {
      _itemlist = List.from(data.docs.map((doc) => dumm.fromSnapshot(doc)));
    }
    );
  }
}
