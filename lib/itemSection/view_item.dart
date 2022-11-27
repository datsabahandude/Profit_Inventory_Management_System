import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummytest/models/profit_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/itemUpdate_model.dart';
import '../models/itemlist_Display.dart';
import '../models/History_model.dart';
import 'edit_item.dart';
import 'manageItem.dart';
import '../models/item_model.dart';

class ViewItem extends StatefulWidget {
  final dumm card;

  ViewItem(
      {
        Key? key,
        required this.card,
      }) : super(key: key);

  @override
  State<ViewItem> createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
  DateTime datenow = DateTime.now();
  final isDialOpen = ValueNotifier(false);
  late TextEditingController quantity;
  String? Iqty;
  String? userid;
  String? Iname;
  String? Isell;
  String? Ibuy;
  String? Idate;
  String? dd;
  String? mm;
  String? yy;
  String? profit;
  String? tprofit;
  String? tprofit2;
  String? itemprofit;
  String? sold;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  ItemModel itemModel = ItemModel();
  ProfitModel profitModel = ProfitModel();
  void initState() {
    // TODO: implement initState
    super.initState();
    quantity = TextEditingController();
    final fireRef = FirebaseFirestore.instance.collection("users").doc(user!.uid);

        fireRef.collection('Items')
        .doc('${widget.card.date}')
        .get()
        .then((value){
      this.itemModel = ItemModel.fromMap(value.data());
      setState((){});

      userid = user!.uid;
      Iqty = '${itemModel.qty}';
      Iname = '${itemModel.iname}';
      Isell = '${itemModel.isell}';
      Ibuy = '${itemModel.ibuy}';
      if(itemModel.tprofit != null){
        itemprofit = '${itemModel.tprofit}';
      }else{
        itemprofit = '0';
      }
      if(itemModel.tsold != null){
        sold = '${itemModel.tsold}';
      }else{
        sold = '0';
      }

    });
    fireRef.collection('Total Profit')
        .doc('1')
        .get()
        .then((value){
      this.profitModel = ProfitModel.fromMap(value.data());
      setState((){});
      if(profitModel.profit != null){
        tprofit = '${profitModel.profit}';
      }else{
       tprofit = '0';
      }
    });
  }
  @override
  void dispose(){
    quantity.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async {
      if (isDialOpen.value){
        isDialOpen.value = false;
        return false;
      } else{
        return true;
      }
    },
    child: Scaffold(
      //backgroundColor: Colors.deepPurpleAccent,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    height: 300,
                    child: Stack(
                      alignment: AlignmentDirectional(-0.95, -0.7),
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Image.network('${widget.card.img}',width: MediaQuery.of(context).size.width,height: 300,fit: BoxFit.cover,),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-0.95, -0.55),
                          child: InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                            },
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Colors.deepPurple,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 10),
                                child: Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            'ITEM NAME',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.deepPurple,
                            border: Border.all(
                              color: Colors.deepPurple,
                              width: 6,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: widget.card.iname==null ? Container() : Text(
                            '${widget.card.iname}',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Color(0xFF090F13),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 2, color: Colors.white,),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 8, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          'Buy price',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.yellowAccent,
                          border: Border.all(
                            color: Colors.yellowAccent,
                            width: 6,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                        child: itemModel.ibuy==null ? Container() : Text(
                          'RM ${itemModel.ibuy}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          'Sell price',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.yellowAccent,
                          border: Border.all(
                            color: Colors.yellowAccent,
                            width: 6,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                        child: itemModel.isell==null ? Container() : Text(
                          'RM ${itemModel.isell}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(height: 2, color: Colors.white,),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Description :',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: widget.card.description==null ? Container() : Text(
                              '${widget.card.description}\n',
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepPurple,
                        border: Border.all(
                          color: Colors.deepPurple,
                          width: 6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 8, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          'Stocks left:',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.yellowAccent,
                          border: Border.all(
                            color: Colors.yellowAccent,
                            width: 6,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                        child: itemModel.qty==null ? Container() : Text(
                          '${itemModel.qty}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.deepPurple,
        animatedIcon: AnimatedIcons.menu_close,
        overlayColor: Colors.purple,
        overlayOpacity: 0.4,
        openCloseDial: isDialOpen,
        children: [
          SpeedDialChild(
              child: Icon(Icons.edit, color: Colors.white),
              label: 'Edit',
              backgroundColor: Colors.black,
              onTap: (){
                showDialog(context: context, builder: (BuildContext context){
                  return AlertDialog(title: Text('You will need to refill the fields',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),),
                  ),
                    content: SingleChildScrollView(
                      child: ListBody(children: [
                        InkWell(splashColor: Colors.redAccent,
                          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EditItem(receive: widget.card)));},
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.edit, color: Colors.redAccent,),
                              ),
                              Text('Proceed >:D', style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w500,
                                ),),),
                            ],),
                        ),
                      ],),),
                  );
                });
              }),
          SpeedDialChild(
              child: Icon(Icons.update, color: Colors.white,),
              label: 'Update',
              backgroundColor: Colors.black,
              onTap: (){
                showDialog(context: context, builder: (BuildContext context){
                  return AlertDialog(title: Text('Choose which action',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.purple,
                      ),),
                  ),
                    content: SingleChildScrollView(
                      child: ListBody(children: [
                        InkWell(splashColor: Colors.purple,
                          onTap: (){
                            BuyDialog();
                            },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.add, color: Colors.redAccent,),
                              ),
                              Text('I want to restock Item (Buy)', style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w500,
                                ),),),
                            ],),
                        ),
                        InkWell(splashColor: Colors.purple,
                          onTap: (){
                            SellDialog();
                            },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.monetization_on_outlined, color: Colors.green,),
                              ),
                              Text('I found a customer :D (Sell)', style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),),),
                            ],),
                        ),
                      ],),),
                  );
                });
              }),
          SpeedDialChild(
              child: Icon(Icons.delete, color: Colors.white,),
              label: 'Delete',
              backgroundColor: Colors.black,
              onTap: (){
                showDialog(context: context, builder: (BuildContext context){
                  return AlertDialog(title: Text('Delete Current Item ?',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),),
                  ),
                    content: SingleChildScrollView(
                      child: ListBody(children: [
                        InkWell(splashColor: Colors.redAccent,
                          onTap: _delete,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.delete, color: Colors.redAccent,),
                              ),
                              Text('Delete Item', style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w500,
                                ),),),
                            ],),
                        ),
                      ],),),
                  );
                });
              }),
        ],
      ),
    ),
  );
  Future<String?> BuyDialog() => showDialog<String?>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Restock how much?',
      style: GoogleFonts.poppins(
        textStyle:TextStyle(color: Colors.deepPurple),
      ),),
      content: TextFormField(
        autofocus: true,
        controller: quantity,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        decoration: InputDecoration(hintText: 'Current stock: ${itemModel.qty}'),
      ),
      actions: [
        TextButton(
        child: Text('Custom Date?',
        style: GoogleFonts.poppins(
          textStyle:TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 16),
        ),),
        onPressed: () async {
          DateTime? newdate = await showDatePicker(
            context: context,
            initialDate: datenow,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (newdate == null) return;
          setState(() => datenow = newdate);
        },
      ),
        TextButton(
            child: Text('Confirm',
              style: GoogleFonts.poppins(
                textStyle:TextStyle(
                    color: Colors.deepPurple,
                fontSize: 16,
                fontWeight: FontWeight.w700),
              ),),
            onPressed: Bsubmit,//() async{//Navigator.of(context).pop(quantity.text);quantity.clear();}
        ),
      ],
    ),
  );
  Future<String?> SellDialog() => showDialog<String?>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Sell how much?',
        style: GoogleFonts.poppins(
          textStyle:TextStyle(color: Colors.deepPurple),
        ),),
      content: TextFormField(
        autofocus: true,
        controller: quantity,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        decoration: InputDecoration(hintText: 'Current stock: ${itemModel.qty}'),
      ),
      actions: [
        TextButton(
          child: Text('Custom Date?',
            style: GoogleFonts.poppins(
              textStyle:TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 16),
            ),),
          onPressed: () async {
            DateTime? newdate = await showDatePicker(
              context: context,
              initialDate: datenow,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (newdate == null) return;
            setState(() => datenow = newdate);
          },
        ),
        TextButton(
          child: Text('Confirm',
            style: GoogleFonts.poppins(
              textStyle:TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),),
          onPressed: Ssubmit,
        ),
      ],
    ),
  );
  Future Bsubmit() async {
    if(quantity.text == null || quantity.text.isEmpty) return;
    var newqty = int.parse(quantity.text) + int.parse(Iqty!);
    HistoryModel qtyModel = HistoryModel();
    UpdateItem updateItem = UpdateItem();
    ProfitModel profitModel = ProfitModel();
    profitModel.yy = '${datenow.year}';
    profitModel.mm = '${datenow.month}';
    profitModel.iname = Iname;
    profitModel.qty = quantity.text;
    updateItem.qty = newqty.toString();
    updateItem.tprofit = itemprofit;
    updateItem.tsold = sold;
    qtyModel.qty = quantity.text;
    qtyModel.ibuy = Ibuy;
    qtyModel.isell = Isell;
    qtyModel.iname = Iname;
    qtyModel.date = '${DateTime.now()}';
    qtyModel.dd = '${datenow.day}';
    qtyModel.mm = '${datenow.month}';
    qtyModel.yy = '${datenow.year}';
    final userRef = await firebaseFirestore.collection("users").doc(userid);
    final dateRef = userRef.collection('Year').doc('${datenow.year}').collection('Month').doc('${datenow.month}');
    userRef.collection('History')
        .doc(qtyModel.date) //empty = random generate
        .set(qtyModel.toMap());
    userRef.collection('Items')
        .doc('${widget.card.date}') //empty = random generate
        .update(updateItem.toMap());
    dateRef.collection('Total Profit').doc('${DateTime.now()}').set(profitModel.toMap());
    //dateRef.collection('Total Profit').doc('${DateTime.now()}').update(profitModel.toMap());
    Fluttertoast.showToast(
        msg: "Stock Added Successfully!\n☆ヾ(-∀・)*+☆", toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepPurple,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => ItemPage()), (route) => false);
  }
  Future Ssubmit() async{
    if((quantity.text == null || quantity.text.isEmpty)) return;
    if (int.parse(quantity.text) > int.parse(Iqty!)) return;
    var newqty = int.parse(Iqty!) - int.parse(quantity.text);
    var earnings =  (double.parse(Isell!) - double.parse(Ibuy!))*(int.parse(quantity.text));
    var totalprofit = earnings + double.parse(tprofit!);
    var itemp = earnings + double.parse(itemprofit!);
    var solp = int.parse(quantity.text) + int.parse(sold!);
    HistoryModel qtyModel = HistoryModel();
    UpdateItem updateItem = UpdateItem();
    ProfitModel profitModel = ProfitModel();
    profitModel.profit = totalprofit.toString();
    profitModel.mm = '${datenow.month}';
    profitModel.yy = '${datenow.year}';
    profitModel.iname = Iname;
    profitModel.iprofit = earnings.toString();
    profitModel.qty = quantity.text;
    updateItem.qty = newqty.toString();
    updateItem.tprofit = itemp.toString();
    updateItem.tsold = solp.toString();
    qtyModel.qty = '-'+quantity.text;
    qtyModel.ibuy = Ibuy;
    qtyModel.isell = Isell;
    qtyModel.iname = Iname;
    qtyModel.date = '${DateTime.now()}';
    qtyModel.dd = '${datenow.day}';
    qtyModel.mm = '${datenow.month}';
    qtyModel.yy = '${datenow.year}';
    qtyModel.profit = earnings.toString();
    final userRef = await firebaseFirestore.collection("users").doc(userid);
    final dateRef = userRef.collection('Year').doc('${datenow.year}').collection('Month').doc('${datenow.month}');
    userRef.collection('History')
        .doc(qtyModel.date) //empty = random generate
        .set(qtyModel.toMap());
    userRef.collection('Items')
        .doc('${widget.card.date}') //empty = random generate
        .update(updateItem.toMap());
    dateRef.collection('Total Profit').doc('${DateTime.now()}').set(profitModel.toMap());
    //dateRef.collection('Total Profit').doc('${DateTime.now()}').update(profitModel.toMap());
    userRef.collection('Total Profit').doc('1').update(profitModel.toMap());
    Fluttertoast.showToast(
        msg: "Stock Updated Successfully!\n(*≧∀≦)ゞ", toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepPurple,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => ItemPage()), (route) => false);
  }
  Future _delete() async{
    User? user = _auth.currentUser;
    ItemModel itemModel = ItemModel();
    itemModel.uid = user!.uid;
    try{
      final docUser = FirebaseFirestore.instance.collection("users")
          .doc(user.uid)
          .collection('Items')
          .doc('${widget.card.date}');
      docUser.delete();
      Fluttertoast.showToast(
          msg: "Item Deleted\n(｡•᎔•｡)", toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      if(widget.card.img != null) {
        FirebaseStorage.instance.refFromURL('${widget.card.img}').delete();}

    } on PlatformException catch (e) {
      Fluttertoast.showToast(
          msg: "Something went wrong!\n(｡•᎔•｡)", toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    Navigator.push(
        context, MaterialPageRoute(
        builder: (context) => ItemPage()));
  }
}
