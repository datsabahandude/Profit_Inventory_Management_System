import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummytest/itemSection/shimmer_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_item.dart';
import '../models/user_model.dart';
import '../models/itemlist_Display.dart';
import '../homePage.dart';
import 'itemcard.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  _ItemPage createState() => _ItemPage();
}

class _ItemPage extends State<ItemPage> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();
  dumm dum = dumm();
  List<Object> _itemlist = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.userModel = UserModel.fromMap(value.data());
      setState(() {});
    });
    getItemList();
  }

  Widget build(BuildContext context) {
    Widget buildShimmer() {
      return const ListTile(
        leading: ShimmerWidget.circular(width: 64, height: 64),
        title: ShimmerWidget.rectangular(height: 16),
        subtitle: ShimmerWidget.rectangular(height: 12),
      );
    }

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
            'MANAGE ITEM',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "Your Shop Name\n(*≧∀≦)ゞ",
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
          ]),
      body: isLoading
          ? Container(
              padding: const EdgeInsets.all(20),
              //width: 200,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return buildShimmer();
                  } //=> build(context),
                  ),
            )
          : Container(
              padding: const EdgeInsets.all(20),
              //width: 200,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _itemlist.length,
                  itemBuilder: (context, index) {
                    return ItemCard(_itemlist[index] as dumm);
                  } //=> build(context),
                  ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddItem()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future getItemList() async {
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection('Items')
        .orderBy('item name', descending: true)
        .get();
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 2), () {});
    setState(() =>
        _itemlist = List.from(data.docs.map((doc) => dumm.fromSnapshot(doc))));
    setState(() => isLoading = false);
  }
}
