import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dummytest/homePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loginPage.dart';
import 'models/feedback_model.dart';
import 'models/user_model.dart';

//void main() => runApp(RegisterPage());
class FeedbackPage extends StatefulWidget {

  @override
  MapScreenState createState() => MapScreenState();
}
class MapScreenState extends State<FeedbackPage> {
  final _formkey = GlobalKey<FormState>();
  final title = new TextEditingController();
  final details = new TextEditingController();
  String name='';
  String shop='';
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
    final titleField = TextFormField(
        autofocus: false,
        controller: title,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter Feedback Title !';
          }
        },
        onSaved: (value){
          name = '${userModel.username}';
          shop = '${userModel.shopname}';
          title.text = value!;
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
            prefixIcon: Icon(Icons.title, color: Colors.purple),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Enter Feedback Title",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ));
    final detailsField = TextFormField(
        minLines: 2,
        maxLines: 6,
        autofocus: false,
        controller: details,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Elaborate !';
          }
        },
        onSaved: (value){
          details.text = value!;
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
            prefixIcon: Icon(Icons.description, color: Colors.purple),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Explanation",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ));

    final submitBtn = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async{
          if (_formkey.currentState!.validate()) {
            _formkey.currentState!.save();
            submit(title.text);
          }
        },
        child: Text(
          "SUBMIT FEEDBACK",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 20, color: Colors.purple, fontWeight: FontWeight.bold
            ),),
        ),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('SEND FEEDBACK',
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
          Container(
            padding: EdgeInsets.all(10),
            child: Text('If you encountered any difficulties while using the system, '
                'please let me know in order for me '
                'to improve the system and provide a better service '
                'in the future. Thank You ! :D ',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 18.0,
              color: Colors.yellow,
              fontWeight: FontWeight.w500,
            ),),
      ),
          ),
              titleField, SizedBox(height: 20.0,),
              detailsField, SizedBox(height: 20.0,),
              submitBtn, SizedBox(height: 20.0,),
            ],
          ),
        ),
      ),
    );
  }

  void submit(String title) async{
    var msg = '';
    try {
      postDetailsToFireStore();
    } on FirebaseAuthException catch (e)
    {
      if (e.code == 'wea-password') {
        print('an error occured');
      } else if (e.code == 'Email Existed') ;
      {
        print('Something went wrong :(');
      }
    }
    catch (e) {
      print(e);
    }
  }
  postDetailsToFireStore() async {
    var date = DateTime.now().toString();
    var dateparse = DateTime.parse(date);
    var formattedDate = "${dateparse.day}/${dateparse.month}/${dateparse.year}";
    //call firestore
    //call user model
    //send values
    User? user = _auth.currentUser;
    FeedbackModel feedModel = FeedbackModel();
    //write all value
    feedModel.email = user!.email;
    feedModel.username = name;
    feedModel.uid = user.uid;
    feedModel.shopname = shop;
    feedModel.date = formattedDate;
    feedModel.title = title.text;
    feedModel.detail = details.text;

    await firebaseFirestore
        .collection("feedback")
        .doc()
        .set(feedModel.toMap());
    Fluttertoast.showToast(
        msg: "Feedback Submitted Successfully!\n( ???? ???? ????)", toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepPurple,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }
}