import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  double imageSize = 150.0; // Initial size of the image
  void toggleImageSize() {
    setState(() {
      // Toggle between original and smaller size
      imageSize = (imageSize == 150.0) ? 100.0 : 150.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            'assets/images/logo.png', //to place here the app icon
            width: 380,
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
            onTap: widget.startQuiz,
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
                  color: Colors.white,
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
