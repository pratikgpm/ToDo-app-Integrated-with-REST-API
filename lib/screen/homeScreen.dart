import 'package:flutter/material.dart';
import 'package:todo_app/screen/add_task.dart';
import 'package:todo_app/services/todo_services.dart';
import 'package:todo_app/util/snackbar_helper.dart';
import 'package:todo_app/widget/todo_card.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List result = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Center(child: Text("Todo List")),
      ),
      floatingActionButton: AddTaskButton(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 5.0, right: 5.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600,
            ),
            child: RefreshIndicator(
              onRefresh: fetchData,
              child: Visibility(
                visible: result.isNotEmpty,
                replacement: Center(
                  child: Text(
                    "Nothing to do!",
                    style: TextStyle(
                        fontSize: 30, color: Colors.white.withOpacity(0.5)),
                  ),
                ),
                child: ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    final item = result[index] as Map;
                    final id = item["_id"] as String;
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(onPressed: (context) async {
                            if(!item["is_completed"]){
                              item["is_completed"] = true;
                              bool execute = await TodoServices.updateTodo(id, item);
                            }
                            else{
                              item["is_completed"] = false;
                              bool execute = await TodoServices.updateTodo(id, item);
                            }
                            fetchData();


                          },
                              icon: item["is_completed"] ? Icons.thumb_down: Icons.thumb_up,
                            backgroundColor: Colors.grey.withOpacity(0.5),


                          ),

                        ],
                      ),
                      child: todoCard(
                          index: index,
                          item: item,
                          navigateUpdate: pageNavigatorUpdate,
                          deleteByTd: deleteId),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pageNavigator() async {
    final rout = MaterialPageRoute(
      builder: (context) => AddTask(),
    );
    await Navigator.push(context, rout);
    fetchData();
  }

  Future<void> pageNavigatorUpdate(Map item) async {
    final rout = MaterialPageRoute(
      builder: (context) => AddTask(todo: item),
    );
    await Navigator.push(context, rout);
    fetchData();
  }

  FloatingActionButton AddTaskButton() {
    return FloatingActionButton.extended(
      backgroundColor: Colors.deepPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      onPressed: pageNavigator,
      label: const Text("Add Task"),
      icon: Icon(Icons.add),
    );
  }

  Future<void> deleteId(String id) async {
    final isSucess = await TodoServices.deleteById(id);
    if (isSucess) {
      final filtered_item =
          result.where((element) => element['_id'] != id).toList();
      setState(() {
        result = filtered_item;
      });
    }
  }

  Future<void> fetchData() async {
    final responce = await TodoServices.fetchTodo();
    if (responce != null) {
      setState(() {
        result = responce;
      });
      setState(() {
        isLoading = false;
      });
    } else {
      showErrorMessage(context, myString: "Some Error occour");
    }
  }
}
