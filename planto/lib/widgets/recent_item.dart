import 'package:flutter/material.dart';

class RecentItem extends StatelessWidget {
  final String name;
  RecentItem(this.name);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('leaf.jpg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  name,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
