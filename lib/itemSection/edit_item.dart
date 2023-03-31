import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummytest/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../models/itemlist_Display.dart';
import 'manageItem.dart';
import '../models/item_model.dart';

class EditItem extends StatefulWidget {
  final dumm receive;
  const EditItem({
    Key? key,
    required this.receive,
  }) : super(key: key);
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<EditItem>
    with SingleTickerProviderStateMixin {
  final _formkey = GlobalKey<FormState>();
  final inameEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final sellpriceEditingController = TextEditingController();
  final buypriceEditingController = TextEditingController();
  final qtyEditingController = TextEditingController();
  String picurl = "";
  String olddate = "";
  String profit = '';
  String sold = '';
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();
  ItemModel itemModel = ItemModel();
  File? image;
  UploadTask? uploadTask;
  String? url;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection('Items')
        .doc('${widget.receive.date}')
        .get()
        .then((value) {
      itemModel = ItemModel.fromMap(value.data());
      setState(() {});
      if (itemModel.tprofit != null) {
        profit = '${itemModel.tprofit}';
      } else {
        profit = '0';
      }
      if (itemModel.tsold != null) {
        sold = '${itemModel.tsold}';
      } else {
        sold = '0';
      }
    });
    if (widget.receive.img != null) {
      url = widget.receive.img;
    }
    inameEditingController.text = widget.receive.iname!;
    descriptionEditingController.text = widget.receive.description!;
    sellpriceEditingController.text = widget.receive.sell!;
    buypriceEditingController.text = widget.receive.buy!;
    qtyEditingController.text = widget.receive.qty!;
  }

  Future uploadFile() async {
    final path = '${user!.uid}/items/${inameEditingController.text}';
    final file = File(image!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() => {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    setState(() {
      url = urlDownload;
    });
    FirebaseStorage.instance.refFromURL(picurl).delete();
    postDetailsToFireStore();
  }

  Future _pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imagetemp = File(image.path);
      setState(() => this.image = imagetemp);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
    Navigator.of(context).pop();
  }

  Future _pickImageGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imagetemp = File(image.path);
      setState(() => this.image = imagetemp);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final inameField = TextFormField(
        autofocus: false,
        controller: inameEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter Item Name !';
          }
          return null;
        },
        onSaved: (value) {
          inameEditingController.text = value!;
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
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "${itemModel.iname}",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));
    final descriptionField = TextFormField(
        autofocus: false,
        controller: descriptionEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter Item Description !';
          }
          return null;
        },
        onSaved: (value) {
          olddate = '${itemModel.date}';
          picurl = '${itemModel.img}';
          descriptionEditingController.text = value!;
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
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "${itemModel.description}",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));
    final buypriceField = TextFormField(
        autofocus: false,
        controller: buypriceEditingController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter Buy Price !';
          }
          var buy = double.parse(buypriceEditingController.text);
          var sell = double.parse(sellpriceEditingController.text);
          if (buy >= sell) {
            return 'Cannot gain profit this way !';
          }
          return null;
        },
        onSaved: (value) {
          buypriceEditingController.text = value!;
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
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Buy Price: ${itemModel.ibuy}*",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));
    final sellpriceField = TextFormField(
        autofocus: false,
        controller: sellpriceEditingController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter Selling price !';
          }
          var buy = double.parse(buypriceEditingController.text);
          var sell = double.parse(sellpriceEditingController.text);
          if (buy > sell) {
            return 'Selling price should be higher than buy price !';
          }
          return null;
        },
        onSaved: (value) {
          sellpriceEditingController.text = value!;
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
            //prefixIcon: Icon(Icons.add_business_rounded, color: Colors.purple),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Selling Price: ${itemModel.isell}*",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));
    final qtyField = TextFormField(
        autofocus: false,
        controller: qtyEditingController,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter Item quantity !';
          }
          return null;
        },
        onSaved: (value) {
          qtyEditingController.text = value!;
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
            //prefixIcon: Icon(Icons.add_business_rounded, color: Colors.purple),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Quantity: ${itemModel.qty}*",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(
          0xff360c72,
        ),
        title: Text(
          'UPDATE ITEM DETAILS',
          style: GoogleFonts.poppins(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: Column(children: [
              Stack(
                children: [
                  image != null
                      ? ClipOval(
                          child: Image.file(
                            image!,
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        )
                      : url != null
                          ? ClipOval(
                              child: Image.network(
                                url!,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const CircleAvatar(
                              backgroundImage:
                                  AssetImage("images/profitinventory.png"),
                              backgroundColor: Colors.transparent,
                              radius: 100),
                  Positioned(
                      top: 120,
                      left: 100,
                      child: RawMaterialButton(
                        elevation: 10,
                        fillColor: Colors.white,
                        padding: const EdgeInsets.all(15),
                        shape: const CircleBorder(),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Choose option',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.purple,
                                      ),
                                    ),
                                  ),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        InkWell(
                                          splashColor: Colors.purpleAccent,
                                          onTap: _pickImageCamera,
                                          child: Row(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.purple,
                                                ),
                                              ),
                                              Text(
                                                'Camera',
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.purple,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.purpleAccent,
                                          onTap: _pickImageGallery,
                                          child: Row(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.image_outlined,
                                                  color: Colors.purple,
                                                ),
                                              ),
                                              Text(
                                                'Gallery',
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.purple,
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
                          Icons.add_a_photo_outlined,
                          color: Colors.purple,
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 50.0,
              ),
              inameField,
              const SizedBox(
                height: 20.0,
              ),
              descriptionField,
              const SizedBox(
                height: 20.0,
              ),
              buypriceField,
              const SizedBox(
                height: 20.0,
              ),
              sellpriceField,
              const SizedBox(
                height: 20.0,
              ),
              Center(child: qtyField),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  child: MaterialButton(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    onPressed: () {
                      if ((_formkey.currentState!.validate()) &&
                          image != null) {
                        _formkey.currentState!.save();
                        update(inameEditingController.text);
                      } else if (image == null) {
                        Fluttertoast.showToast(
                            msg: "Please Upload an Image!",
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
                      "UPDATE ITEM",
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
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void update(String username) async {
    try {
      uploadFile();
      //postDetailsToFireStore();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wea-password') {
        debugPrint('Something went Wrong :(');
      } else if (e.code == 'Something went Wrong :(') {
        debugPrint('Failed to Add Item D:');
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future postDetailsToFireStore() async {
    var date = DateTime.now().toString();
    //var dateparse = DateTime.parse(date);
    //var formattedDate = "${dateparse.day}-${dateparse.month}-${dateparse.year}";
    //call firestore
    //call user model
    //send values
    User? user = _auth.currentUser;
    ItemModel itemModel = ItemModel();
    //write all value
    itemModel.iname = inameEditingController.text;
    itemModel.uid = user!.uid;
    itemModel.description = descriptionEditingController.text;
    itemModel.date = date;
    itemModel.tsold = sold;
    itemModel.tprofit = profit;
    itemModel.qty = qtyEditingController.text;
    itemModel.isell = sellpriceEditingController.text;
    itemModel.ibuy = buypriceEditingController.text;
    itemModel.img = url;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .collection('Items')
        .doc(itemModel.date) //empty = random generate
        .set(itemModel.toMap());
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .collection('Items')
        .doc(olddate)
        .delete();
    Fluttertoast.showToast(
        msg: "Item Edited Successfully!\n(,,･`∀･)ﾉ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const ItemPage()),
        (route) => false);
  }
}
