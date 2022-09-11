import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/itemlist_Display.dart';

class BestCard extends StatelessWidget {
  final dumm card;

  BestCard(this.card);
  /*const ItemCard(
      {
        Key? key,
        required this.iname,
      }) : super(key: key);*/
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: double.infinity,
      ),
      child: Card(
        shadowColor: Colors.deepPurple,
        elevation: 8,
        child: ListTile(
          tileColor: Colors.pink[900],
          leading: CircleAvatar(radius: 28, backgroundImage: NetworkImage('${card.img}')),
          title: Text('${card.iname}', style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.yellowAccent, fontSize: 18, fontWeight: FontWeight.bold),),),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: Text("Stock Sold: ${card.sold}",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: Colors.purple[200], fontWeight: FontWeight.w600)
                      ),),
                  ),
                  Spacer(),
                  Container(
                    child: Text("Profit: RM ${card.profit}",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: Color(0xff13f61c), fontWeight: FontWeight.w600)
                      ),),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
