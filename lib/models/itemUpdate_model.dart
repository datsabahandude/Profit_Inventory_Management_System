class UpdateItem {
  String? qty;
  String? tprofit;
  String? tsold;
  UpdateItem({this.qty, this.tprofit, this.tsold});

  //retrieve data from server
  factory UpdateItem.fromMap(map){
    return UpdateItem(
      qty: map['quantity'],
      tprofit: map['profits'],
      tsold: map['sold'],
    );
  }
//send data to server
  Map<String, dynamic> toMap(){
    return {
      'quantity' : qty,
      'profits' : tprofit,
      'sold' : tsold,
    };
  }

}