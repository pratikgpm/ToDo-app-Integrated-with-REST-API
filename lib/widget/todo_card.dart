import 'package:flutter/material.dart';


class todoCard extends StatefulWidget {
  final int index;
  final Map item;
  final Function(Map) navigateUpdate;
  final Function(String) deleteByTd;
  const todoCard({super.key,
  required this.index,
    required this.item,
    required this.navigateUpdate,
    required this.deleteByTd,
  });

  @override
  State<todoCard> createState() => _todoCardState();
}

class _todoCardState extends State<todoCard> {
  @override
  Widget build(BuildContext context) {
    final id = widget.item["_id"] as String;
    final status = widget.item["is_completed"] as bool;
    return Card(
      color:  status ? Colors.green.withOpacity(0.3): null,
      child: ListTile(
        leading: CircleAvatar(
          child: Text("${widget.index + 1}"),
          radius: 15,
        ),
        title: Text(widget.item["title"]),
        subtitle: Text(widget.item["description"].toString()),
        trailing: PopupMenuButton(
          icon: Icon(
            Icons.more_horiz,
            size: 25,
          ),
          onSelected: (value) {
            if (value == 'edit') {
              widget.navigateUpdate(widget.item);
            }
            else if (value == 'delete') {
              widget.deleteByTd(id);
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(child: Text("Edit"), value: 'edit'),
              PopupMenuItem(
                child: Text('Delete'),
                value: 'delete',
              ),
            ];
          },
        ),
      ),
    );
  }

}
