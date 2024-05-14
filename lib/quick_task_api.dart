import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class QuickTaskAPIController {

  Future<String?> validateUserLogin(String username, String password) async {
    //Filters objects in which a specific key’s value is equal to the provided value.
    final QueryBuilder<ParseObject> usernameQuery = QueryBuilder<ParseObject>(ParseObject('_User'));
    usernameQuery.whereEqualTo('username', username);

    final QueryBuilder<ParseObject> passwordQuery = QueryBuilder<ParseObject>(ParseObject('_User'));
    passwordQuery.whereEqualTo('password', password);

    final QueryBuilder<ParseObject> loginQuery = QueryBuilder.or(ParseObject('_User'), [usernameQuery, passwordQuery]);
    
    final apiResponse = await loginQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      for (var object in apiResponse.results as List<ParseObject>) {
        print('Valid user: ${object.objectId} - ${object.get<String>('username')}');
        return object.objectId;
      }
    }

    return "";
  }

  // Future<List<ParseObject>> 
  Future<List<ParseObject>> getAllTasks() async {
    // List tasks = [];
    // ParseObject('Task').getAll().then((value) => tasks);
    // return tasks;

    QueryBuilder<ParseObject> queryTodo =
    QueryBuilder<ParseObject>(ParseObject('Task'));
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results as List<ParseObject>;
    } else {
      return [];
    }
  }

  Future<void> saveTask(String title, DateTime dueDate) async {
    final task = ParseObject('Task')
                    ..set('Title', title)
                    ..set('DueDate', dueDate)
                    ..set('Status', 'To Do');
    await task.save();
  }

  Future<ParseObject> getTaskDetails(String objectId) async {
    //This quick method is used to retrieve a single ParseObject instance when you know its objectId.
    ///To retrieve one object of a Class it is not necessary to create a ParseQuery.
    ///We can query using ParseObject
    final apiResponse = await ParseObject('Task').getObject(objectId);

    if (apiResponse.success && apiResponse.results != null) {
      var tasks = apiResponse.results as List<ParseObject>;
      for (var o in tasks) {
        final object = o as ParseObject;
        print('${object.objectId} - ${object.get<String>('Title')}');
        return object;
      }
    }

    return ParseObject('Task');
  }

  Future<dynamic> updateTask(String objectId, bool done) async {
    var taskStatus;
    if(done)
      taskStatus = 'Done';

    var task = ParseObject('Task')
                  ..objectId = objectId
                  ..set('Status', taskStatus)
                  ..set('CompletionDate', DateTime.now());
    var saveResponse = await task.save();
    return saveResponse.result;
  }

  Future<void> deleteTask(String objectId) async {
      var task = ParseObject('Task')..objectId = objectId;
      await task.delete();
  }

  Future<List> getListData(String url) async {
    try {
      // final r = await dio.get(url);
      // Map<String, dynamic> data = jsonDecode(r.toString());
      var data = [];
      var errorResponse;
      List responses  = await ParseObject('Task').getAll().then((value) => data).onError((error, stackTrace) => errorResponse);
      return data;
      // if(data["code"] == 100) {
      //   return data["data"] as List;
      // }
    } catch (e) {
      print(e);
    }
    return [];
  }

}