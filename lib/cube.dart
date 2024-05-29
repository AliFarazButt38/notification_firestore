import 'package:flutter/material.dart';
import 'dart:math' as math;

class CubePage extends StatefulWidget {
  @override
  _CubePageState createState() => _CubePageState();
}

class _CubePageState extends State<CubePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("3D Rotating Cube"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..rotateX(0.5 * math.pi * _animationController.value)
                ..rotateY(0.7 * math.pi * _animationController.value),
              child: Cube(),
            );
          },
        ),
      ),
    );
  }
}

class Cube extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 50,
            child: CubeFace(color: Colors.red),
          ),
          Positioned(
            top: 50,
            left: 150,
            child: CubeFace(color: Colors.orange),
          ),
          Positioned(
            top: 50,
            left: 250,
            child: CubeFace(color: Colors.yellow),
          ),
          Positioned(
            top: 50,
            left: 350,
            child: CubeFace(color: Colors.green),
          ),
          Positioned(
            top: 150,
            left: 50,
            child: CubeFace(color: Colors.blue),
          ),
          Positioned(
            top: 150,
            left: 150,
            child: CubeFace(color: Colors.purple),
          ),
          Positioned(
            top: 150,
            left: 250,
            child: CubeFace(color: Colors.cyan),
          ),
          Positioned(
            top: 150,
            left: 350,
            child: CubeFace(color: Colors.pink),
          ),
          Positioned(
            top: 250,
            left: 50,
            child: CubeFace(color: Colors.white),
          ),
          Positioned(
            top: 250,
            left: 150,
            child: CubeFace(color: Colors.black),
          ),
          Positioned(
            top: 250,
            left: 250,
            child: CubeFace(color: Colors.grey),
          ),
          Positioned(
            top: 250,
            left: 350,
            child: CubeFace(color: Colors.brown),
          ),
        ],
      ),
    );
  }
}

class CubeFace extends StatelessWidget {
  final Color color;

  const CubeFace({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }
}
