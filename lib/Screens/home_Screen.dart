import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllerr/auth_controller.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final AuthController controller =
  Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final user = controller
        .getCurrentUser();

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.white,

        elevation: 0,

        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              controller.logout();
            },

            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 20),

            const Text(
              "Welcome 🎉",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              user?.email ?? "User",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 30),

            // CARD
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(25),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                BorderRadius.circular(20),

                boxShadow: [
                  BoxShadow(
                    color:
                    Colors.black.withOpacity(0.06),

                    blurRadius: 15,

                    offset:
                    const Offset(0, 5),
                  ),
                ],
              ),

              child: Column(
                children: [

                  Container(
                    height: 70,
                    width: 70,

                    decoration:
                    const BoxDecoration(
                      color: Color(0xffE8F1FF),
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                      size: 45,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "You are logged in!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Firebase Authentication is working successfully.",
                    textAlign:
                    TextAlign.center,

                    style: TextStyle(
                      color:
                      Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // USER CARD
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.blue,

                borderRadius:
                BorderRadius.circular(18),
              ),

              child: Row(
                children: [

                  const CircleAvatar(
                    radius: 28,

                    backgroundColor:
                    Colors.white,

                    child: Icon(
                      Icons.person,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        const Text(
                          "Logged in user",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          user?.email ??
                              "No email",

                          style:
                          const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}