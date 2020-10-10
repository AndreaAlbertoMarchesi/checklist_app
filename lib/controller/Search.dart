import 'package:checklist_app/model/AppState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends SearchDelegate{

  String selectedResult;
  List<String> titles=[];
  List<String> recentList=[];

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
    final appState = context.watch<AppState>();
    ///titles = appState.getTitles();

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
          onTap: (){
            ///appState.goToTask(suggestionList[index]);
            Navigator.of(context).pop();
          },
        );
      }
    );
  }
}