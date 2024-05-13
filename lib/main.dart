import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'qt_login_screen.dart';
import 'quick_task_api.dart';
import 'qt_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final keyApplicationId = 'QqLgfR1ECqwlxRbmgEWhjvyZZZ3dWZFZjSsNzkBR';
  final keyClientKey = '5yja7O7jEbg8NxqG0fGxyveGVQIEgt2hrUXNUACd';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  var taskController = QuickTaskAPIController();
  var tasks = await taskController.getAllTasks();
  for(int i=0;i < tasks.length;i++)
    print(tasks[i]['Title'] + " is due on " + tasks[i]['DueDate'].toString());

  runApp(const MainApp());

  // runApp(MaterialApp(
  //   home: Home()
  // ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Home(),
        ),
      ),
    );
  }
}
