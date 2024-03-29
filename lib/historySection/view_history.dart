import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/historylist_Display.dart';
import '../models/item_model.dart';
import '../models/profit_model.dart';
import 'manageHistory.dart';

class ViewHistory extends StatefulWidget {
  final hiss card;

  const ViewHistory({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  State<ViewHistory> createState() => _ViewHistoryState();
}

class _ViewHistoryState extends State<ViewHistory> {
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  ProfitModel profitModel = ProfitModel();
  String message = '';
  String ran = '0';
  String message2 = '';
  String tprofit = '0';
  var num = 0;
  double newprofit = 0;
  String date = '';
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
  }

  @override
  Widget build(BuildContext context) {
    date = '${widget.card.dd}/${widget.card.mm}/${widget.card.yy}';
    ran = widget.card.qty!;
    if (widget.card.profit == null) {
      message2 = 'Stock increase: +${widget.card.qty}';
    } else {
      message = 'Profit: \$ ${widget.card.profit}';
      message2 = 'Stock change: ${widget.card.qty}';
      newprofit = double.parse(tprofit) - double.parse(widget.card.profit!);
      num = 1;
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
                MaterialPageRoute(builder: (context) => const HistoryPage()));
          },
        ),
        backgroundColor: const Color(
          0xff360c72,
        ),
        title: Text(
          'SELECTED RECORD',
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: Text(
                  'Item Name: ${widget.card.iname}\n'
                  'Date: $date\n$message2\n$message',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                // widget.card.profit!.isEmpty
                //     ? const Text('Item Name \nDate \nStock increase')
                //     : const Text(
                //         'Item Name \nDate \nStock Change \nProfit '),
                // widget.card.profit!.isEmpty
                //     ? Text(
                //         ': ${widget.card.iname}\n: $date\n: +${widget.card.qty}')
                //     : Text(
                //         ': ${widget.card.iname}\n: $date\n: -${widget.card.qty}\n: \$ ${widget.card.profit}'),
                // ],
                // )
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Delete Item Record ?',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          InkWell(
                            splashColor: Colors.redAccent,
                            onTap: _delete,
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                ),
                                Text(
                                  'Delete Record',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          )),
    );
  }

  Future _delete() async {
    User? user = _auth.currentUser;
    ItemModel itemModel = ItemModel();
    itemModel.uid = user!.uid;
    try {
      if (num == 1) {
        ProfitModel profitModel = ProfitModel();
        profitModel.profit = newprofit.toString();
        final userRef =
            FirebaseFirestore.instance.collection("users").doc(user.uid);
        userRef.collection('Total Profit').doc('1').update(profitModel.toMap());
      }
      final docUser = FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection('History')
          .doc('${widget.card.date}');
      docUser.delete();
      Fluttertoast.showToast(
          msg: "Record Deleted\n(｡•᎔•｡)",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // Fluttertoast.showToast(
      //     msg: "Something went wrong!\n(｡•᎔•｡)",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HistoryPage()));
  }
}
