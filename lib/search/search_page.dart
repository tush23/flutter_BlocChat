import 'package:flutter/material.dart';
import 'package:flutterchatdemo/constants/constants.dart';
import 'package:flutterchatdemo/search/index.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = '/search';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchBloc = SearchBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: tPrimaryColor,
      ),
      body: SearchScreen(searchBloc: _searchBloc),
    );
  }
}
