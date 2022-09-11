class dumm{
  String? iname;
  String? description;
  String? buy;
  String? sell;
  String? qty;
  String? img;
  String? profit;
  String? sold;
  String? date;
  dumm();

  Map<String, dynamic> toJson() => {'item name' : iname, 'description' : description, 'image url' : img, 'buy price' : buy,'sell price' : sell,'quantity' : qty, 'date' : date};
  dumm.fromSnapshot(snapshot) :
        iname = snapshot.data()['item name'],
        date = snapshot.data()['date'],
        profit = snapshot.data()['profits'],
        sold = snapshot.data()['sold'],
        buy = snapshot.data()['buy price'],
        sell = snapshot.data()['sell price'],
        qty = snapshot.data()['quantity'],
        description = snapshot.data()['description'],
        img = snapshot.data()['image url'];
}