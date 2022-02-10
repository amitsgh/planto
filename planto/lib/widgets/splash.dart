import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        //color: Colors.white,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              SizedBox(width: 100, child: Image.asset('logo.png')),
              SizedBox(width: 200, child: Image.asset('label.png')),
              SizedBox(
                height: 100,
              ),
              SizedBox(child: Image.asset('plants.png')),
            ],
          ),
        ),
      ),
    );
  }
}
