import 'package:flutter/material.dart';

class Search extends SearchDelegate{

  String selectedResult;
  final List<String> titles;
  List<String> recentList=[];
  Search(this.titles);



  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: (){
            query= "";
          },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pop(context);
        }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList
        : suggestionList.addAll(titles.where(
            (element) => element.contains(query),
    ));
    return ListView.builder(
      itemCount: suggestionList.length ,
      itemBuilder: (context,index){
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
        );
      }
    );
  }
}