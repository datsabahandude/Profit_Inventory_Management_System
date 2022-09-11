import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'registerPage.dart';
//import 'dummy.dart';
import 'homePage.dart';

void main() => runApp(LoginPage());
class LoginPage extends StatefulWidget {
  _LoginPage createState() => _LoginPage();
}
class _LoginPage extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  late String _email, _password;
  FirebaseAuth _auth = FirebaseAuth.instance;
  void _loginSave() async {
    var msg = '';
    try {
      UserCredential userCredential = await FirebaseAuth.instance.
      signInWithEmailAndPassword(email: _email, password: _password);
      Fluttertoast.showToast(
          msg: "(☞ﾟ∀ﾟ)☞ Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }catch (e) {
      Fluttertoast.showToast(
          msg: "ｰ(  ｰ̀дｰ́ )Incorrect Credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  Widget _buildEmail() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: TextFormField(

        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {},
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          errorStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 16.0,
              color: Colors.yellow,
              fontWeight: FontWeight.w700,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(
            Icons.email,
            color: Colors.purple,
          ),
          labelText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.purple),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter your Email !';
          }
          else if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
              return("Please Enter a valid Email");
            }
          return null;
        },
        onSaved: (val) => setState(() => _email = val!),
      ),
    );
  }
  Widget _buildPassword() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: TextFormField(
        obscureText: true,
        onChanged: (value) {},
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          errorStyle: GoogleFonts.poppins(textStyle: TextStyle(
            fontSize: 16.0,
            color: Colors.yellow,
            fontWeight: FontWeight.w700,
          ),),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.purple,
          ),
          labelText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.purple),
          ),
        ),
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return 'Please Enter your Password !';
          }
          if(!regex.hasMatch(value)){
            return("Please Enter Valid Password !");
          };
        },
        onSaved: (val) => setState(() => _password = val!),
      ),
    );
  }

  Widget _buildLogin() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width * 0.6,
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            _formkey.currentState!.save();
            _loginSave();
          }
        },
        child: Text(
          "LOGIN",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 20,
              color: Color(0xff360c72),
              fontWeight: FontWeight.bold
          ),),
        ),
      ),);
  }
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff360c72,),
      resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            child: Stack(
              children: [
                /*Container(
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
                        ),
                  ),
                ),*/
                Form(
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
                      _buildEmail(), SizedBox(height: 5),
                      _buildPassword(), SizedBox(height: 10),
                      _buildLogin(), Padding(padding: EdgeInsets.all(5.0)),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Don't have an account? ",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16, color:
                              Colors.white
                              ),),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegisterPage()));
                            },
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.yellowAccent,
                              ),),
                            ),)
                        ],
                      ),
                          ],
                  ),
                      ),
                        ],
            ),
                ),
    ),
        ),
    );
  }
}