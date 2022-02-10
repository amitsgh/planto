import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:planto/Model/diseasemodel.dart';

class Disease with ChangeNotifier {
  List<DiseaseModel> _diseases = [];

  List<DiseaseModel> get diseases {
    return [..._diseases];
  }

  Future<void> findRecentSearch() async {
    const url = 'https://planto-965f9-default-rtdb.firebaseio.com/sample.json';
    try {
      final response = await http.get(Uri.parse(url));
      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<DiseaseModel> recentSearch = [];
      extractedData.forEach((diseaseId, diseaseData) {
        recentSearch.add(DiseaseModel(
          id: diseaseId,
          name: diseaseData['name'],
        ));
      });
      _diseases = recentSearch;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
