import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final bool isSuccess;

  CustomAlertDialog({
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onButtonPressed,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 280,
        height: 320,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 45,
              child: Container(
                width: 280,
                height: 275,
                decoration: ShapeDecoration(
                  color: Color(0xFFF5F5F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 15,
                      offset: Offset(0, 4),
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 18,
              top: 130,
              child: SizedBox(
                width: 243,
                height: 130,
                child: Column(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                        height:
                            8), // Adjust the spacing between title and message
                    Text(
                      message,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 92,
              top: 0,
              child: isSuccess
                  ? Container()
                  : Image.asset(
                      'assets/Ok.png',
                      width: 100,
                      height: 90,
                      fit: BoxFit.contain,
                    )
            ),
            Positioned(
              left: 92,
              top: 0,
              child: isSuccess
                  ? Image.asset(
                      'assets/Ok.png',
                      width: 100,
                      height: 90,
                      fit: BoxFit.contain,
                    )
                  : Container(), // You can remove the Container if not needed
            ),
            Positioned(
              left: 92,
              top: 230,
              child: ElevatedButton(
                onPressed: onButtonPressed,
                style: ElevatedButton.styleFrom(
                  primary: Color(0xAF018241),
                  minimumSize: Size(95, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
