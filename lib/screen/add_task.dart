import 'package:flutter/material.dart';
import 'package:todo_app/services/todo_services.dart';
import 'package:todo_app/util/snackbar_helper.dart';
import 'package:todo_app/widget/description_textField.dart';

class AddTask extends StatefulWidget {
  final Map? todo;

  const AddTask({
    super.key,
    this.todo,
  });

  @override
  State<AddTask> createState() => AddTaskState();
}

class AddTaskState extends State<AddTask> {
  TextEditingController title_controller = TextEditingController();
  TextEditingController description_controller = TextEditingController();
  bool isEdit = false;
  var id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final data = widget.todo;
    if (data != null) {
      isEdit = true;
      title_controller.text = data["title"];
      description_controller.text = data["description"];
      id = data["_id"].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(isEdit ? "Edit Task" : "Add Task"),
        backgroundColor: Colors.grey.shade900,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 20.0, right: 20.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                titleTextField(editing_controller: title_controller),
                descriptio_textField(description_Controller: description_controller),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: isEdit ? updateData : setData,
                  child: Text(
                    isEdit ? "Update" : "Submt",
                    style: TextStyle(color: Colors.white),
                  ),
                  style:
                  ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.deepPurple)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateData() async {
    //using body getter
    //submit data to server
    final isSucessfull = await TodoServices.updateTodo(id, body);
    if (isSucessfull) {
      shoeSucessMessage(context, myString: "Update Sucessfully");
    } else {
      showErrorMessage(context, myString: "Cant Update");
    }
  }

  void setData() async {
    //accuring  the resources
    // accuiring - using body-getter
    //submitb data to server
    final isSucessfull = await TodoServices.setTodo(body);
    if (isSucessfull) {
      shoeSucessMessage(context, myString: "Sucessful...");
      title_controller.text = "";
      description_controller.text = "";
    } else {
      showErrorMessage(context, myString: "Error Occour");
    }
  }

  // getter body (we are using controller just to get the value form filds and put it into map)
  //no need to store them explicitly
  Map get body {
    var title = title_controller.text;
    var description = description_controller.text;
    return {"title": title, "description": description, "is_completed": false};
  }
}
