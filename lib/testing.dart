import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Testing extends StatelessWidget {
  const Testing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 500,
        child: Stack(
          children: [
            Container(
              color: Colors.green,
              height: 500,
              width: double.infinity,
            ),
            // Positioned(
            //   bottom: 0,
            //   child: ClipPath(
            //     clipper: SteppedSlopeClipper1(),
            //     child: ShaderMask(
            //       shaderCallback: (Rect bounds) {
            //         return LinearGradient(
            //           // begin: Alignment.bottomLeft,
            //           // end: Alignment.bottomCenter,
            //           colors: [
            //             Colors.white.withOpacity(0.5),
            //             Colors.white,
            //           ],
            //         ).createShader(bounds);
            //       },
            //       blendMode: BlendMode.dstOut,
            //       child: Container(
            //         height: 100,
            //         width: MediaQuery.sizeOf(context).width,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
            Positioned(
              bottom: 0,
              child: ClipPath(
                clipper: SteppedSlopeClipper2(),
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      // begin: Alignment.bottomLeft,
                      // end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.5),
                        Colors.white,
                      ],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstOut,
                  child: Container(
                    height: 100,
                    width: MediaQuery.sizeOf(context).width,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SteppedSlopeClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SteppedSlopeClipper2 extends CustomClipper<Path> {
  @override
Path getClip(Size size) {
  final path = Path();

  // Start at the top left corner
  path.moveTo(0.0, 0.0);

  // Draw a straight line to the bottom right corner, creating the opposite slope
  path.lineTo(size.width, size.height);

  // Draw a diagonal line to the middle left edge
  path.lineTo(0.0, size.height );

  // Close the path to form the triangle shape
  path.close();

  return path;
}

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
