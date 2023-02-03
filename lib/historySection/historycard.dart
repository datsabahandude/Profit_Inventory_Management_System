import 'package:dummytest/historySection/view_history.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/historylist_Display.dart';

class HistoryCard extends StatelessWidget {
  final hiss card;
  String message = '';
  String ran = '0';
  String message2 = '';
  var num;

  HistoryCard(this.card);

  /*const ItemCard(
      {
        Key? key,
        required this.iname,
      }) : super(key: key);*/
  @override
  Widget build(BuildContext context) {
    ran = card.qty!;
    if (card.profit == null) {
      message2 = 'Stock increase: +${card.qty}';
    } else {
      message = 'Profit: RM ${card.profit}';
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
            "Date: ${card.dd}/${card.mm}/${card.yy}\n$message2",
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
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewHistory(
                          card: card,
                        )));
          },
        ),
      ),
    );
  }
}
