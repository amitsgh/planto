import 'package:flutter/material.dart';
import 'package:planto/Model/diseaseProvider.dart';
import 'package:planto/widgets/recent_item.dart';
import 'package:provider/provider.dart';

class RecentSearch extends StatefulWidget {
  @override
  _RecentSearchState createState() => _RecentSearchState();
}

class _RecentSearchState extends State<RecentSearch> {
  var _isInit = true;
  var _isloading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isloading = true;
      });
      Provider.of<Disease>(context).findRecentSearch().then((_) {
        _isloading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final diseaseData = Provider.of<Disease>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Image.asset('label.png'))
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: diseaseData.diseases.length,
                itemBuilder: (_, i) => Column(
                  children: [
                    RecentItem(diseaseData.diseases[i].name),
                  ],
                ),
              ),
            ),
    );
  }
}
