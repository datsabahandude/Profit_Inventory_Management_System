class ItemModel {
  String? uid;
  String? iname;
  String? isell;
  String? ibuy;
  String? date;
  String? qty;
  String? tprofit;
  String? tsold;
  String? description;
  String? img;
  ItemModel({this.uid, this.iname, this.isell, this.ibuy, this.date, this.qty, this.description, this.img, this.tprofit, this.tsold});

  //retrieve data from server
  factory ItemModel.fromMap(map){
    return ItemModel(
        uid: map['uid'],
        iname: map['item name'],
        isell: map['sell price'],
        ibuy: map['buy price'],
        date: map['date'],
        qty: map['quantity'],
        description: map['description'],
        img: map['image url'],
        tprofit: map['profits'],
        tsold: map['sold'],
    );
  }
//send data to server
  Map<String, dynamic> toMap(){
    return {
      'uid' : uid,
      'item name' : iname,
      'sell price' : isell,
      'buy price' : ibuy,
      'date' : date,
      'quantity' : qty,
      'description' : description,
      'image url' : img,
      'profits' : tprofit,
      'sold' : tsold,
    };
  }

}