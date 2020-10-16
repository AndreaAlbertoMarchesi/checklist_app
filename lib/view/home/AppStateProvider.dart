import 'package:checklist_app/model/AppState.dart';
import 'package:checklist_app/services/Database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Home.dart';

class AppStateProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        create: (_) => AppState(),
        child: Home()
    );
  }
}
