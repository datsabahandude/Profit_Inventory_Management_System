import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/historylist_Display.dart';
import '../models/user_model.dart';
import '../homePage.dart';
import 'historycard.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _ItemPage createState() => _ItemPage();
}

class _ItemPage extends State<HistoryPage> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();
  hiss his = hiss();
  List<Object> _hisslist = [];
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.userModel = UserModel.fromMap(value.data());
      setState(() {});
    });
    getHistoryList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          backgroundColor: const Color(
            0xff360c72,
          ),
          title: Text(
            'HISTORY',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "Your Shop Name\n๑و•̀Δ•́)و",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.purple,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: userModel.shopname == null
                  ? Container()
                  : Text(
                      "${userModel.shopname}",
                      style: GoogleFonts.spaceMono(
                        textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.yellowAccent,
                            //decoration: TextDecoration.underline,
                            //decorationThickness: 1,
                            decorationColor: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
            ),
            //new Icon(Icons.add_business_rounded, color: Colors.white, size: 30,),
          ]),
      body: Container(
        padding: const EdgeInsets.all(20),
        //width: 200,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _hisslist.length,
            itemBuilder: (context, index) {
              final item = _hisslist[index];
              return HistoryCard(item as hiss);
            } //=> build(context),
            ),
      ),
    );
  }

  Future getHistoryList() async {
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection('History')
        .orderBy('date', descending: true)
        .get();
    setState(() {
      _hisslist = List.from(data.docs.map((doc) => hiss.fromSnapshot(doc)));
    });
  }
}
