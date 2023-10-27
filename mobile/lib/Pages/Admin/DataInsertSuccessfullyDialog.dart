import 'package:flutter/material.dart';
import 'ShowMyproperty.dart';

class DataInsertSuccessfullyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 280, // Adjusted width
        height: 320, // Adjusted height
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 45, // Adjusted top position
              child: Container(
                width: 280, // Adjusted width
                height: 275, // Adjusted height
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 280, // Adjusted width
                        height: 275, // Adjusted height
                        decoration: ShapeDecoration(
                          color: Color(0xFFF5F5F5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15), // Adjusted border radius
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 15, // Adjusted blur radius
                              offset: Offset(0, 4),
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 18,
                      top: 45, // Adjusted top position
                      child: SizedBox(
                        width: 243, // Adjusted width
                        height: 130, // Adjusted height
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '\n ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18, // Adjusted font size
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: 'සාර්ථකයි\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24, // Adjusted font size
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: '\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18, // Adjusted font size
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: 'තොරතුරු ඇතුලත් කරගන්නා ලදී...\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16, // Adjusted font size
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: '\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18, // Adjusted font size
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 92,
                      top: 200, // Adjusted top position
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => MyProperty(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xAF018241),
                          minimumSize: Size(95, 40), // Adjusted size
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15), // Adjusted border radius
                          ),
                        ),
                        child: Text(
                          'ආපසු',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20, // Adjusted font size
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 92,
              top: 0,
              child: Container(
                width: 100, // Adjusted width
                height: 90, // Adjusted height
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Ok.png'),
                    fit: BoxFit.contain,
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
