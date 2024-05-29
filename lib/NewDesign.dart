import 'package:flutter/material.dart';

class NewDesign extends StatefulWidget {
  const NewDesign({Key? key}) : super(key: key);

  @override
  State<NewDesign> createState() => _NewDesignState();
}

class _NewDesignState extends State<NewDesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Property 1=check.png'), // Add your image path here
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  " Account Created\n     Successfully",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    color: Colors.white, // Set text color to white
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
