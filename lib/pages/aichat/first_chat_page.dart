import 'package:flutter/material.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/pages/aichat/chat.dart';


class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [greenText, darkGreen],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 400, 
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    bottom: 40,
                    child: Image.asset(
                      'assets/images/line.png', 
                    ),
                  ),
                  Positioned(
                    bottom:
                        45, 
                    child: Image.asset(
                      'assets/images/saedLogo.png', 
                      width: 180,
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right:
                        10, 
                    child: Container(
                      width: 100, 
                      height: 40, 
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(30.0), 
                        border:
                            Border.all(color: Colors.transparent), 
                      ),
                      child: const Center(
                        child: Text(
                          "مرحبا سارة", // Replace with your text
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              '           أنا ساعد\nكيف يمكنني مساعدتك؟',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                context.pushTo(view: Chat());
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), 
                ),
                side: BorderSide.none, 
                fixedSize: Size(200, 50), 
              ),
              child: Image.asset(
                'assets/images/Vector.png', 
                width: 50, 
                height: 30, 
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'انقر للتحدث',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}