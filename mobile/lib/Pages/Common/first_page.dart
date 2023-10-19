import 'package:flutter/material.dart';
import 'package:mobile/utils.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Image.asset(
          "assets/home_img.jpg", // Replace with your image asset path
          height: double.infinity,
          width: double.infinity,
          scale: 0.1,
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(0, 90, 90,
                    90), // You can change the transparent color to any color you want
                const Color.fromARGB(97, 0, 0, 0),
                const Color.fromARGB(202, 0, 0, 0),
                Color.fromARGB(230, 0, 0, 0)
                    .withOpacity(1.0), // Adjust the opacity and color as needed
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 150.0, left: 15.0),
            child: Row(
              children: [
                Image.asset(
                  "assets/Sri Goviya.png",
                  height: 130,
                  width: 130,
                  scale: 0.1,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0,),
                  child: Text(
                    'Sri Goviya',
                    style: SafeGoogleFont(
                      'Yu Gothic UI',
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      height: 1.8,
                      letterSpacing: 2.24,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Color.fromARGB(5, 149, 165, 2)
                .withOpacity(0.7), // Background color of the small box
            height: 122, // Adjust the height as needed
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Login Btn
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(166, 1, 58, 14)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ), // Set the corner radius
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                        const Size(114, 45)), // Set custom button size here
                  ),
                  child: const Text("Login"),
                ),

                //SignUp Btn
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(166, 1, 58, 14)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ), // Set the corner radius
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                        const Size(114, 45)), // Set custom button size here
                  ),
                  child: const Text("Sign up"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
