class hiss{
  String? iname;
  String? dd;
  String? mm;
  String? yy;
  String? date;
  String? profit;
  String? qty;
  hiss();

  Map<String, dynamic> toJson() => {'item name' : iname, 'date' : date, 'dat created' : dd, 'month created' : mm, 'year created' : yy, 'profit earned' : profit, 'quantity' : qty};
  hiss.fromSnapshot(snapshot) :
        iname = snapshot.data()['item name'],
        date = snapshot.data()['date'],
        dd = snapshot.data()['day created'],
        mm = snapshot.data()['month created'],
        yy = snapshot.data()['year created'],
        qty = snapshot.data()['quantity'],
        profit = snapshot.data()['profit earned'];
}