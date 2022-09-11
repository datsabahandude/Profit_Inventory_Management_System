class ProfitModel{
  String? profit;
  String? yy;
  String? mm;
  String? iprofit;
  String? iname;
  String? qty;
  ProfitModel({this.profit, this.yy, this.iname, this.qty, this.mm, this.iprofit});
  factory ProfitModel.fromMap(map){
    return ProfitModel(
      profit: map['profit earned'],
      yy: map['year'],
      mm: map['month'],
      iname: map['item'],
      iprofit: map['profit'],
      qty: map['quantity'],
    );
  }
  Map<String, dynamic> toMap(){
    return {
      'profit earned' : profit,
      'year' : yy,
      'profit' : iprofit,
      'month' : mm,
      'item' : iname,
      'quantity' : qty,
    };
  }
}