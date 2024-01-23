import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPage extends StatelessWidget {
  const StartPage(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            '', //to place here the app icon
            width: 300,
            color: const Color.fromARGB(150, 255, 255, 255),
          ),
          const SizedBox(height: 80),
          // Text(
          //   'Text Here',
          //   style: GoogleFonts.lato(
          //     color: const Color.fromARGB(255, 237, 223, 252),
          //     fontSize: 24,
          //   ),
          // ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: startQuiz,
            child: Container(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 126, 200, 218),
                    Color(0xff0066ff),
                  ],
                ),
              ),
              child: const Text(
                'BEGIN',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom().copyWith(),
          //   onPressed: startQuiz,
          //   child: const Text(
          //     'BEGIN',
          //     style: TextStyle(
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
