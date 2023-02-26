import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/History_model.dart';
import '../models/specifdatelist.dart';
import 'dateCard.dart';
import 'manageAnalytics.dart';

class DatePage extends StatefulWidget {
  const DatePage({
    Key? key,
    required this.month,
    required this.year,
  }) : super(key: key);
  final String month, year;

  @override
  _DatePage createState() => _DatePage();
}

class _DatePage extends State<DatePage> {
  //FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  HistoryModel historyModel = HistoryModel();
  spec his = spec();
  List<Object> _speclist = [];
  @override
  void initState() {
    super.initState();
    getSpecList();
  }

  @override
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
                MaterialPageRoute(builder: (context) => const AnalyticsPage()));
          },
        ),
        backgroundColor: const Color(
          0xff360c72,
        ),
        title: Text(
          'Year: ${widget.year} Month: ${widget.month}',
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        //width: 200,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _speclist.length,
            itemBuilder: (context, index) {
              final item = _speclist[index];
              return DateCard(item as spec);
            } //=> build(context),
            ),
      ),
    );
  }

  Future getSpecList() async {
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection('Year')
        .doc(widget.year)
        .collection('Month')
        .doc(widget.month)
        .collection('Total Profit')
        .get();
    setState(() {
      _speclist = List.from(data.docs.map((doc) => spec.fromSnapshot(doc)));
    });
  }
}
