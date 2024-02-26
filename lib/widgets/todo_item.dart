import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/ToDo.dart';

class todo_item extends StatelessWidget{
  final ToDo todo;
  final ontodochange;
  final ondelete;
  const todo_item({super.key,required this.todo,required this.ontodochange,required this.ondelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap:() {
          ontodochange(todo);
        },
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ,
        tileColor: Colors.white,
        leading: Icon(todo.isDone?Icons.check_box:Icons.check_box_outline_blank,color: Colors.deepPurple),
        title: Text(todo.todoText!,style: TextStyle(fontSize: 16,color: Colors.black,decoration: todo.isDone?TextDecoration.lineThrough:null)),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child:IconButton(
             color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: (){
               ondelete(todo.id);
            },

          ),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: 15, left: 15,right: 15
      ),
    );
  }


}
