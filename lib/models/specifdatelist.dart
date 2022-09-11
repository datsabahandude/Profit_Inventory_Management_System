class spec{
  String? iname;
  String? mm;
  String? yy;
  String? profit;
  String? qty;
  String? iprofit;
  spec();

  Map<String, dynamic> toJson() => {'item' : iname, 'month' : mm, 'profit' : iprofit, 'year' : yy, 'profit earned' : profit, 'quantity' : qty};
  spec.fromSnapshot(snapshot) :
        iname = snapshot.data()['item'],
        mm = snapshot.data()['month'],
        iprofit = snapshot.data()['profit'],
        yy = snapshot.data()['year'],
        qty = snapshot.data()['quantity'],
        profit = snapshot.data()['profit earned'];
}