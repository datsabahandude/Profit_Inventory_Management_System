import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummytest/analyticsSection/specificDate.dart';
import 'package:dummytest/models/profit_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/historylist_Display.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final month = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  final year = ['2021', '2022', '2023', '2024', '2025'];
  String? mm;
  String? yy;
  String total = '';
  User? user = FirebaseAuth.instance.currentUser;
  String tprofit = '';
  OverlayEntry? entry;
  ProfitModel profitModel = ProfitModel();
  hiss his = hiss();
  @override
  void initState() {
    super.initState();
    final fireRef =
        FirebaseFirestore.instance.collection("users").doc(user!.uid);
    fireRef.collection('Total Profit').doc('1').get().then((value) {
      this.profitModel = ProfitModel.fromMap(value.data());
      setState(() {});
      if (profitModel.profit != null) {
        tprofit = '${profitModel.profit}';
      } else {
        tprofit = '0';
      }
    });
    //WidgetsBinding.instance.addPostFrameCallback((_) => showOverlay());
  }

  @override
  void dispose() {
    //controller.dispose();
    super.dispose();
  }

  Widget buildOverlay() => Material(
        elevation: 8,
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text('January'),
              onTap: () {},
            )
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    if (tprofit != null) {
      total = '0';
    } else {
      tprofit = '0';
    }
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xff360c72),
              Color(0xcc360c72),
              Color(0x99360c72),
              Color(0x66360c72),
            ])),
        child: Form(
          //key: _formkey,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Select Date',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.yellow,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              //titleField, SizedBox(height: 20.0,),
              Row(
                children: [
                  Text(
                    'Month',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.yellow,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<String>(
                      dropdownColor: Colors.deepPurple,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.yellow,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      value: mm,
                      items: month.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() => this.mm = value),
                    ),
                  ),
                  const Spacer(), //SizedBox(width: 20.0,),
                  Text(
                    'Year',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.yellow,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<String>(
                      dropdownColor: Colors.deepPurple,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.yellow,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      value: yy,
                      items: year.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() => this.yy = value),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width * 0.6,
                  onPressed: () {
                    if ((mm != null) && (yy != null)) {
                      String MM = mm.toString();
                      String YY = yy.toString();
                      /*try{
                        final specificdate = FirebaseFirestore.instance.collection('users')
                            .doc(user!.uid)
                            .collection('History')
                            .where(((double.parse('month created') >= double.parse(mm!))
                            && (double.parse('month created') <= double.parse(mm!)))
                            &&((double.parse('year created') >= double.parse(yy!))
                                &&(double.parse('year created') <= double.parse(yy!))))
                            .get();
                        specificdate.then((value) {
                          //this.profitModel= ProfitModel.fromMap(value.data());
                        });

                      }catch (e){
                        Fluttertoast.showToast(
                            msg: "No Matching Date Found!", toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }*/
                      //Navigator.of(context).pop(mm.toString(), yy.toString());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DatePage(
                                    month: MM,
                                    year: YY,
                                  )));
                    } else {
                      Fluttertoast.showToast(
                          msg: "Invalid Input",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Text(
                    "View Report",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 20,
                          color: Color(0xff360c72),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xff13f61c)),
                child: Text(
                  'Total Profit: RM $tprofit',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 20,
                        color: Color(0xff360c72),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              //width: 200,
              /*Container(
                padding: EdgeInsets.all(5),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _hisslist.length,
                    itemBuilder: (context, index) {
                      final item = _hisslist[index];
                      return DateCard(_hisslist[index] as hiss);
                    } //=> build(context),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      );
  Future searchData() async {}
  /*Future getHistoryList() async{
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection('History')
        .orderBy('profit earned', descending: false)
        .get();
    setState(() {
      _hisslist = List.from(data.docs.map((doc) => hiss.fromSnapshot(doc)));
    }
    );
  }*/
}
