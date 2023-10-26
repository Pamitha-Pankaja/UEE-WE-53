import 'package:flutter/material.dart';

class FillAllFieldDialog extends StatelessWidget {
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
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
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
                      top: 45,
                      child: SizedBox(
                        width: 243,
                        height: 130,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '\n ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: 'WARNING\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: '\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: 'සියලු විස්තර ඇතුලත් කරන්න...\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: '\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
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
                      top: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(173, 238, 114, 76),
                          minimumSize: Size(95, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'ආපසු',
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
            ),
            Positioned(
              left: 92,
              top: 0,
              child: Container(
                width: 100,
                height: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Error.png'),
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
