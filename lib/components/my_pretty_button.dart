import 'package:flutter/material.dart';

class MyPrettyButton extends StatelessWidget {
  final void Function()? buttonCallBack;
  final String buttonText;

  const MyPrettyButton({
    super.key,
    required this.buttonText,
    required this.buttonCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.07,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: const Color.fromARGB(255, 95, 204, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: buttonCallBack,
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
