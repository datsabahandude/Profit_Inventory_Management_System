import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummytest/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homePage.dart';

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final _formkey = GlobalKey<FormState>();
  final usernameEditingController = new TextEditingController();
  final shopnameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final dateEditingController = new TextEditingController();
  String email="";
  String date ="";
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();

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
    final usernameField = TextFormField(
        autofocus: false,
        controller: usernameEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter your Username !';
          }
        },
        onSaved: (value){
          usernameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorStyle: GoogleFonts.poppins(
              textStyle: TextStyle(
              fontSize: 12.0,
              color: Colors.yellow,
              fontWeight: FontWeight.w700,
            ),),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(Icons.account_circle_rounded, color: Colors.purple),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "${userModel.username}",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ));
    final shopnameField = TextFormField(
        autofocus: false,
        controller: shopnameEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter your Shop name !';
          }
        },
        onSaved: (value){
          shopnameEditingController.text = value!;
          email = "${userModel.email}";
          date = "${userModel.joindate}";
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorStyle: GoogleFonts.poppins(
              textStyle: TextStyle(
              fontSize: 12.0,
              color: Colors.yellow,
              fontWeight: FontWeight.w700,
            ),),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(Icons.add_business_rounded, color: Colors.purple),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "${userModel.shopname}",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('PROFILE',
        style: GoogleFonts.poppins(),),
      ),
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

                //emailField, SizedBox(height: 20.0,),
                usernameField, SizedBox(height: 20.0,),
                shopnameField, SizedBox(height: 20.0,),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  child: MaterialButton(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        update(usernameEditingController.text);
                      }
                    },
                    child: Text(
                      "Update",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Color(0xff360c72),
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  ),
                ),
              ]
          ),
        ),
      ),);
  }

  @override
  void update(String username) async{
    var msg = '';
    try {
      postDetailsToFireStore();
    } on FirebaseAuthException catch (e)
    {
      if (e.code == 'wea-password') {
        print('Something went wrong :(');
      } else if (e.code == 'Something went wrong :(') ;
      {
        print('Failed to Update D:');
      }
    }
    catch (e) {
      print(e);
    }
  }
  postDetailsToFireStore() async {
    //call firestore
    //call user model
    //send values
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    //write all value
    userModel.email = email;
    userModel.username = usernameEditingController.text;
    userModel.uid = user!.uid;
    userModel.shopname = shopnameEditingController.text;
    userModel.joindate = date;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap()); // or use .update(*values to change*) //.delete() to delete the document
    Fluttertoast.showToast(
        msg: "Account Updated Successfully\n(๑و•̀Δ•́)و",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }
}