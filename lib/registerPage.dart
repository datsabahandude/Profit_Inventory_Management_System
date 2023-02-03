import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummytest/models/profit_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dummytest/homePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loginPage.dart';
import 'models/user_model.dart';

//void main() => runApp(RegisterPage());
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();
  final emailEditingController = TextEditingController();
  final usernameEditingController = TextEditingController();
  final shopnameEditingController = TextEditingController();
  final passEditingController = TextEditingController();
  final cpassEditingController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter your Email !';
          } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid Email");
          }
        },
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorStyle: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 12.0,
                color: Colors.yellow,
                fontWeight: FontWeight.w700,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.mail, color: Colors.purple),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Enter Your Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));
    final usernameField = TextFormField(
        autofocus: false,
        controller: usernameEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter your Username !';
          }
        },
        onSaved: (value) {
          usernameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorStyle: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 12.0,
                color: Colors.yellow,
                fontWeight: FontWeight.w700,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon:
                const Icon(Icons.account_circle_rounded, color: Colors.purple),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Enter Your Username",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));
    final shopnameField = TextFormField(
        autofocus: false,
        controller: shopnameEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter your Shop name !';
          }
        },
        onSaved: (value) {
          shopnameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorStyle: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 12.0,
                color: Colors.yellow,
                fontWeight: FontWeight.w700,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon:
                const Icon(Icons.add_business_rounded, color: Colors.purple),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Enter Your Store/Shop name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));
    final passField = TextFormField(
        autofocus: false,
        controller: passEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return 'Please Enter your Password !';
          }
          if (!regex.hasMatch(value)) {
            return ("Please Enter Valid Password !");
          }
          return null;
        },
        onSaved: (value) {
          passEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorStyle: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 12.0,
                color: Colors.yellow,
                fontWeight: FontWeight.w700,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.vpn_key, color: Colors.purple),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Create Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));
    final cpassField = TextFormField(
        autofocus: false,
        controller: cpassEditingController,
        obscureText: true,
        validator: (value) {
          if (cpassEditingController.text != passEditingController.text) {
            return 'Password does not Match !';
          }
          return null;
        },
        onSaved: (value) {
          cpassEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorStyle: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 12.0,
                color: Colors.yellow,
                fontWeight: FontWeight.w700,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.vpn_key, color: Colors.purple),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Confirm Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));
    final signUpBtn = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          if (_formkey.currentState!.validate()) {
            _formkey.currentState!.save();
            signUp(emailEditingController.text, passEditingController.text);
          }
        },
        child: Text(
          "SIGN UP",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                fontSize: 22,
                color: Colors.purple,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Create New Account',
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Container(
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
          key: _formkey,
          child: Column(
            children: [
              emailField,
              const SizedBox(
                height: 20.0,
              ),
              usernameField,
              const SizedBox(
                height: 20.0,
              ),
              shopnameField,
              const SizedBox(
                height: 20.0,
              ),
              passField,
              const SizedBox(
                height: 20.0,
              ),
              cpassField,
              const SizedBox(
                height: 20.0,
              ),
              signUpBtn,
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    var msg = '';
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      postDetailsToFireStore();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wea-password') {
        print('Provided password is weak');
      } else if (e.code == 'Email Existed') ;
      {
        print('Account Existed');
      }
    } catch (e) {
      print(e);
    }
  }

  postDetailsToFireStore() async {
    var date = DateTime.now().toString();
    var dateparse = DateTime.parse(date);
    var formattedDate = "${dateparse.day}-${dateparse.month}-${dateparse.year}";
    //call firestore
    //call user model
    //send values
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    ProfitModel profitModel = ProfitModel();
    //write all value
    profitModel.profit = '0';
    userModel.email = user!.email;
    userModel.username = usernameEditingController.text;
    userModel.uid = user.uid;
    userModel.shopname = shopnameEditingController.text;
    userModel.joindate = formattedDate;
    final Ref = await firebaseFirestore.collection("users").doc(user.uid);
    Ref.set(userModel.toMap());
    Ref.collection('Total Profit').doc('1').set(profitModel.toMap());
    Fluttertoast.showToast(
        msg: "Registration Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }
}
