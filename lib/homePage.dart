import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummytest/dummy.dart';
import 'package:dummytest/registerPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'analyticsSection/manageAnalytics.dart';
import 'feedbackPage.dart';
import 'historySection/manageHistory.dart';
import 'itemSection/edit_item.dart';
import 'loginPage.dart';
import 'itemSection/manageItem.dart';
import 'models/user_model.dart';
import 'userPage.dart';
//import 'dummy.dart';


//void main() => runApp(HomePage());
class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final _formkey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();

  Widget _manageItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                child: MaterialButton(
                  //padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                    minWidth: MediaQuery.of(context).size.width * 0.60,
                    onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ItemPage()));
                    },
                    child: Text(
                      "MANAGE ITEM",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inknutAntiqua(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Color(0xff360c72),
                          fontWeight: FontWeight.bold
                      ),),
                    )
                )
            )

          ]
          , ), ], );
  }
  Widget _saleshistory() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                child: MaterialButton(
                  //padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                    minWidth: MediaQuery.of(context).size.width * 0.60,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HistoryPage()));
                    },
                    child: Text(
                      "SALES HISTORY",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inknutAntiqua(
                        textStyle: TextStyle(
                            fontSize: 18,
                            color: Color(0xff360c72),
                            fontWeight: FontWeight.bold
                        ),),
                    )
                )
            )

          ]
          , ), ], );
  }
  Widget _analytics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                child: MaterialButton(
                  //padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                    minWidth: MediaQuery.of(context).size.width * 0.60,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AnalyticsPage()));
                    },
                    child: Text(
                      "ANALYTICS",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inknutAntiqua(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Color(0xff360c72),
                          fontWeight: FontWeight.bold
                      ),),
                    )
                )
            )

          ]
          , ), ], );
  }
  Widget _feedback() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                child: MaterialButton(
                  //padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                    minWidth: MediaQuery.of(context).size.width * 0.60,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()));
                    },
                    child: Text(
                      "SEND FEEDBACK",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inknutAntiqua(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Color(0xff360c72),
                          fontWeight: FontWeight.bold
                      ),),
                    )
                )
            )

          ]
          , ), ], );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance.collection("users")
        .doc(user!.uid)
        .get()
        .then((value){
      this.userModel = UserModel.fromMap(value.data());
      setState((){});
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
            },
            child: userModel.username==null ? Container() : Text(
                "${userModel.username} ",
              style: GoogleFonts.spaceMono(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.yellowAccent,
                  decorationColor: Colors.white,
                  fontWeight: FontWeight.w800
              ),),
            ),
          ),
          new Icon(Icons.account_circle_rounded, color: Colors.white, size: 30,),
        ],backgroundColor: Color(0xff360c72),
        elevation: 0.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff360c72),
                    Color(0xcc360c72),
                    Color(0x99360c72),
                    Color(0x66360c72),
                  ]
              )
          ),
          child: Form(
            key: _formkey,
            child: Column(

              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/profitinventory.png"),
                    backgroundColor: Colors.transparent,
                    radius: 140,
                  ),
                ),
                SizedBox(height: 10,),
                    _manageItem(), SizedBox(height: 10,),
                _saleshistory(), SizedBox(height: 10,),
                    _analytics(), SizedBox(height: 10,),
                _feedback(),
                  ],
                ),
          ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        icon: Icon(Icons.exit_to_app_outlined),
        label: Text('Logout',
        style: GoogleFonts.poppins(),),
        backgroundColor: Colors.deepPurple,
        onPressed: () => {
        setState((){
        FirebaseAuth.instance.signOut();
        }),
        Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LoginPage()))
        },
      ),
    );
  }
}