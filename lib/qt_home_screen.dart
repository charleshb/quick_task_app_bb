import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:quick_task_app_bb/quick_task_api.dart';

/* void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final keyApplicationId = 'YOUR_APP_ID_HERE';
  final keyClientKey = 'YOUR_CLIENT_KEY_HERE';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);

  runApp(MaterialApp(
    home: Home(),
  ));
} */

class QTHome extends StatefulWidget {
  @override
  _QTHomeState createState() => _QTHomeState();
}

class _QTHomeState extends State<QTHome> {
  final taskController = TextEditingController();
  var qtApiController = QuickTaskAPIController();

  void addTask() async {
    if (taskController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Empty title"),
        duration: Duration(seconds: 2),
      ));
      return;
    }

    DateTime dueDateToSet = DateTime.now().add(const Duration(days:1));
    await qtApiController.saveTask(taskController.text, dueDateToSet);
    setState(() {
      taskController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task List"),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      autocorrect: true,
                      textCapitalization: TextCapitalization.sentences,
                      controller: taskController,
                      decoration: InputDecoration(
                          labelText: "New Task",
                          labelStyle: TextStyle(color: Colors.deepPurpleAccent)),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurpleAccent,
                      ),
                      onPressed: addTask,
                      child: Text("ADD")),
                ],
              )),
          Expanded(
              child: FutureBuilder<List<ParseObject>>(
                  future: qtApiController.getAllTasks(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: Container(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator()),
                        );
                      default:
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error..."),
                          );
                        }
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("No Data..."),
                          );
                        } else {
                          return ListView.builder(
                              padding: EdgeInsets.only(top: 10.0),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                               //*************************************
                                //Get Parse Object Values
                                final varTodo = snapshot.data![index];
                                final varTitle = varTodo['Title'];
                                final varSubTitle = varTodo['DueDate'].toString().trimRight();
                                final varDone = (varTodo['Status'] == 'Done');
                                //*************************************

                                return ListTile(
                                  title: Text(varTitle),
                                  subtitle: Text(varSubTitle),
                                  leading: CircleAvatar(
                                    child: Icon(
                                        varDone ? Icons.check : Icons.error),
                                    backgroundColor:
                                        varDone ? Colors.green : Colors.purpleAccent,
                                    foregroundColor: Colors.white,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: varDone,
                                          onChanged: (value) async {
                                            await updateTaskOnChanged(varTodo, value);
                                          }),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.purpleAccent,
                                        ),
                                        onPressed: () async {
                                          await deleteTaskOnPressed(varTodo, context);
                                        },
                                      )
                                    ],
                                  ),
                                );
                              });
                        }
                    }
                  }))
        ],
      ),
    );
  }

  Future<void> updateTaskOnChanged(ParseObject varTodo, bool? value) async {
    await qtApiController.updateTask(
        varTodo.objectId!, value!);
    setState(() {
      //Refresh UI
    });
  }

  Future<void> deleteTaskOnPressed(ParseObject varTodo, BuildContext context) async {
    await qtApiController.deleteTask(varTodo.objectId!);
    setState(() {
      final snackBar = SnackBar(
        content: Text("Todo deleted!"),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    });
  }


}