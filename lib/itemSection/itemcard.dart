import 'package:dummytest/itemSection/view_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/itemlist_Display.dart';

class ItemCard extends StatelessWidget {
  final dumm card;

  ItemCard(this.card);
  /*const ItemCard(
      {
        Key? key,
        required this.iname,
      }) : super(key: key);*/
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: double.infinity,
      ),
      child: Card(
        shadowColor: Colors.deepPurple,
        elevation: 8,
        child: ListTile(
          tileColor: Colors.yellow[300],
          leading: card.img == null
              ? const CircularProgressIndicator(
                  backgroundColor: Colors.deepPurple,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
              : CircleAvatar(
                  radius: 28, backgroundImage: NetworkImage('${card.img}')),
          title: Text(
            '${card.iname}',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Buy: \$ ${card.buy}",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w600)),
                  ),
                  const Spacer(),
                  Text(
                    "Sell: \$ ${card.sell}",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.w600)),
                  )
                ],
              ),
              Text(
                "Stock: ${card.qty}",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          isThreeLine: true,
          trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => //HomePage())
                        ViewItem(
                          card: card,
                        )));
          },
        ),
      ),
    );
  }
}
