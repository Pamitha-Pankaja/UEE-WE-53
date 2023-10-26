import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String selectedOption = "Farmer"; // Default selected option
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                  const Color.fromARGB(110, 0, 0, 0),
                  const Color.fromARGB(255, 0, 0, 0).withOpacity(
                      1.0), // Adjust the opacity and color as needed
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft:
                      Radius.circular(30.0), // Set the top-left corner radius
                  topRight:
                      Radius.circular(30.0), // Set the top-right corner radius
                ),
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(144, 0, 0, 0),
                    Color.fromARGB(148, 149, 165, 2).withOpacity(1.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                // color: const Color.fromARGB(1, 237, 189, 21)
                //     .withOpacity(0.7), // Background color of the small box
              ),
              height: 470, // Adjust the height as needed
              width: double.infinity,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 30.0),

                  //User Option
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Center the buttons horizontally
                    children: [
                      //Farmer
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedOption =
                                "Farmer"; // Update the selected option
                          });
                          // Navigator.of(context).pushNamed('/sm_navbar');
                        },
                        child: Text(
                          "Farmer",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: selectedOption == "Farmer"
                                ? const Color.fromARGB(255, 255, 208,
                                    0) // Change this color to your desired color
                                : Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(width: 30.0),

                      //Supplier
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedOption =
                                "Buyer"; // Update the selected option
                          });
                          // Navigator.pushNamed(context, '/sp_navbar',arguments: 1);
                        },
                        child: Text(
                          "Buyer",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: selectedOption == "Buyer"
                                ? const Color.fromARGB(255, 255, 208,
                                    0) // Change this color to your desired color
                                : Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(width: 30.0),

                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedOption =
                                "Agri Officer"; // Update the selected option
                          });
                          // Navigator.pushNamed(context, '/sp_navbar',arguments: 1);
                        },
                        child: Text(
                          "Agri Officer",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: selectedOption == "Agri Officer"
                                ? const Color.fromARGB(255, 255, 208,
                                    0) // Change this color to your desired color
                                : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Email Field
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10.0), // Set the corner radius here
                        color: const Color.fromARGB(190, 217, 217, 217),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Color.fromARGB(200, 0, 0, 0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          border: InputBorder.none, // Remove the default border
                          filled: true,
                        ),
                        cursorColor: const Color.fromARGB(211, 0, 0, 0),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20.0),

                  // Password Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10.0), // Set the corner radius here
                        color: const Color.fromARGB(225, 217, 217, 217),
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            color: Color.fromARGB(200, 0, 0, 0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          border: InputBorder.none, // Remove the default border
                          filled: true,
                        ),
                        cursorColor: const Color.fromARGB(211, 0, 0, 0),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20.0),

                  // Re-enter Password Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10.0), // Set the corner radius here
                        color: const Color.fromARGB(225, 217, 217, 217),
                      ),
                      child: TextFormField(
                        controller: reEnterPasswordController,
                        decoration: const InputDecoration(
                          labelText: "Re-enter Password",
                          labelStyle: TextStyle(
                            color: Color.fromARGB(200, 0, 0, 0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          border: InputBorder.none, // Remove the default border
                          filled: true,
                        ),
                        cursorColor: const Color.fromARGB(211, 0, 0, 0),
                      ),
                    ),
                  ),

                  //Login Btn
                  const SizedBox(height: 25.0),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final String email = emailController.text;
                        final String password = passwordController.text;

                        // Create a new user account using email and password
                        UserCredential? userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        if (userCredential.user != null) {
                          // If userCredential and user are not null, proceed with the user ID.
                          String userId = userCredential.user!.uid;

                          // Determine the user's role (site_manager or supplier)
                          String userRole;

                          if (selectedOption == "Farmer") {
                            userRole = "farmer";
                          } else if (selectedOption == "Buyer") {
                            userRole = "buyer";
                          } else if (selectedOption == "Agri Officer") {
                            userRole = "agri_officer";
                          } else {
                            // Handle the case where selectedOption doesn't match any of the above conditions
                            // You can set a default value or raise an error as needed.
                            userRole = "unknown";
                          }

                          // Store user data in the "users" collection
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(userId)
                              .set({
                            'email': email,
                            'role': userRole,
                            // Add other user data fields here...
                          });
                          // Create a new document with an auto-generated unique ID in the respective collection
                          if (userRole == "farmer") {
                            await FirebaseFirestore.instance
                                .collection('farmers')
                                .add({
                              'userId': userId,
                              'email': email,
                              'password': password,
                              // Add other site manager data fields here...
                            });
                          } else if (userRole == "buyer") {
                            await FirebaseFirestore.instance
                                .collection('buyers')
                                .add({
                              'userId': userId,
                              'email': email,
                              'password': password,
                              // Add other supplier data fields here...
                            });
                          } else if (userRole == "agri_officer") {
                            await FirebaseFirestore.instance
                                .collection('agri_officers')
                                .add({
                              'userId': userId,
                              'email': email,
                              'password': password,
                              'status':1,
                              // Add other supplier data fields here...
                            });
                          }
                        }

                        // After successful sign-up, you can navigate to a different screen:
                        Navigator.of(context).pushNamed('/login');

                        // Clear the text fields after successful sign-up
                        emailController.clear();
                        passwordController.clear();
                        reEnterPasswordController.clear();
                      } catch (e) {
                        // Handle sign-up errors (e.g., email is already in use)
                        print('Error during sign-up: $e');
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(166, 1, 58, 14)),
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
      ),
    );
  }
}
