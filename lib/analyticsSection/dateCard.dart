import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/specifdatelist.dart';

class DateCard extends StatelessWidget {
  final spec card;
  String message = '';
  String message2 = '';
  var num;

  DateCard(this.card);
  @override
  Widget build(BuildContext context) {
    if (card.profit == null) {
      message2 = 'Stock increase: +${card.qty}';
    } else {
      message = 'Profit: \$ ${card.iprofit}';
      message2 = 'Stock change: ${card.qty}';
    }

    return Container(
      constraints: const BoxConstraints(
        maxHeight: double.infinity,
      ),
      child: Card(
        shadowColor: Colors.deepPurple,
        elevation: 8,
        child: ListTile(
          tileColor: Colors.yellow[200],
          //leading: CircleAvatar(radius: 28, backgroundImage: NetworkImage('${card.img}')),
          title: Text(
            '${card.iname}',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Text(
            "Year: ${card.yy}\n Month: ${card.mm}\n$message2",
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500)),
          ),
          isThreeLine: true,
          trailing: Text(
            message,
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: Colors.green, fontWeight: FontWeight.w700)),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
