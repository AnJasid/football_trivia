import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    required this.iconData,
  });

  final String buttonText;
  final void Function() onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                )),
            child: CircleAvatar(
              backgroundColor: const Color(0xff37AFA1),
              radius: 30,
              child: Center(
                child: Icon(
                  iconData,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            buttonText,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
