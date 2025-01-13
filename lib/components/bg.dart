import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
     /* body: Container(
  decoration: BoxDecoration(
    image: Image.asset('assets/images/lgbg.jpeg'),
    fit: BoxFit.cover,
  ),
),*/

    // body: Container(decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: Image.asset('lib/images/lgbg.jpeg'))),),
     body: SingleChildScrollView(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/bg.png',
              fit: BoxFit.cover,
              
              
            ),
            
          ],
        ),
     ),
    );
  }
}