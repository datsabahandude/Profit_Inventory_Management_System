class HistoryModel {
  String? iname;
  String? isell;
  String? ibuy;
  String? date;
  String? qty;
  String? yy;
  String? mm;
  String? dd;
  String? profit;

  HistoryModel({this.iname, this.isell, this.ibuy, this.date, this.qty, this.yy, this.mm, this.dd, this.profit});

  //retrieve data from server
  factory HistoryModel.fromMap(map){
    return HistoryModel(
      iname: map['item name'],
      isell: map['sell price'],
      ibuy: map['buy price'],
      date: map['date'],
      qty: map['quantity'],
      dd: map['day created'],
      mm: map['month created'],
      yy: map['year created'],
      profit:  map['profit earned']
    );
  }
//send data to server
  Map<String, dynamic> toMap(){
    return {
      'item name' : iname,
      'sell price' : isell,
      'buy price' : ibuy,
      'date' : date,
      'quantity' : qty,
      'day created' : dd,
      'month created' : mm,
      'year created' : yy,
      'profit earned' : profit,
    };
  }

}