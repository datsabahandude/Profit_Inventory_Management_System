import 'package:dummytest/analyticsSection/bestScreen.dart';
import 'package:dummytest/analyticsSection/salesScreen.dart';
import 'package:dummytest/analyticsSection/tostockScreen.dart';
import 'package:dummytest/homePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  int index = 0;
  final screens = [
    const SalesScreen(),
    const BestScreen(),
    const StockScreen(),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          backgroundColor: const Color(
            0xff360c72,
          ),
          title: Text(
            'ANALYTICS REPORT',
            style: GoogleFonts.poppins(),
          ),
        ),
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.black,
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          child: NavigationBar(
            height: 60,
            backgroundColor: const Color(
              0xff360c72,
            ),
            selectedIndex: index,
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
            destinations: const [
              NavigationDestination(
                  icon: Icon(
                    Icons.event_note,
                    color: Colors.white,
                  ),
                  label: 'Sales Report'),
              NavigationDestination(
                  icon: Icon(
                    Icons.monetization_on_outlined,
                    color: Colors.white,
                  ),
                  label: 'Best-Selling'),
              NavigationDestination(
                  icon: Icon(
                    Icons.add_shopping_cart_outlined,
                    color: Colors.white,
                  ),
                  label: 'To-Stock')
            ],
          ),
        ),
      );
}
