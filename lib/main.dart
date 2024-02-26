import 'package:flutter/material.dart';
import 'package:flutter_first/widgets/todo_item.dart';
import 'package:flutter_first/model/ToDo.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final addText = TextEditingController() ;
  final todolist = ToDo.todoList();
  List<ToDo> _foundToDo =[];

  void initState(){
    super.initState();
    _foundToDo=todolist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Icon(Icons.menu,color: Colors.deepPurple,size:30),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape:BoxShape.circle,
                color: Colors.deepPurple
              ),
              child:Icon(Icons.person,color: Colors.white,size: 30),
            )
          ]
        )
      ),
      body: Stack(
        children: [
          Container(
          child:Column(
            children: [
             searchBox(),
              Expanded(child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top:20,bottom: 50),
                    child: Center(
                      child: Text("All To Do's",
                        style:TextStyle(fontSize: 20,fontWeight:FontWeight.w500),
                      ),
                    ),
                  ),
                  for(ToDo todo in _foundToDo)
                    todo_item(todo: todo,
                        ontodochange: handle,
                        ondelete:handleDelete,
                      ),

                ],
              )
              )
            ],
          )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    top: 20,
                    left: 20,

                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const[BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0,0.0),
                      blurRadius:10.0,
                      spreadRadius: 0.0,
                    ),],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:TextField(
                    controller: addText,
                    decoration: InputDecoration(
                      hintText: "Add new todo item",
                      border: InputBorder.none,
                    ),
                  )
                )),
                Container(
                  margin: EdgeInsets.all(20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                        minimumSize: Size(50, 50),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                        ),
                      ),
                      child:Text("+",style: TextStyle(fontSize: 40,color: Colors.white),),
                      onPressed:(){
                        _addToDoItem(addText.text.toString());
                      },
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }

  void handle(ToDo todo){
    setState(() {
      todo.isDone=!todo.isDone;
    });
  }

  void handleDelete(String id){
    setState(() {
      todolist.removeWhere((item) => item.id==id);
    });
  }

  void _addToDoItem(String todoText){
    setState(() {
       todolist.add(ToDo(id: DateTime.now().microsecondsSinceEpoch.toString(), todoText: todoText));
    });
    addText.clear();
  }

  void _runFilter(String text){
    List<ToDo>? results=[];
    if(text.isEmpty){
      results=todolist;
    }
    else{
      results=todolist.where((item) =>item.todoText!.toLowerCase().contains(text.toLowerCase())).toList();
    }
    setState(() {
       _foundToDo=results!;
    });
  }

  Widget searchBox(){
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),

        child:TextField(
          onChanged: (value)=>_runFilter(value),
          decoration: InputDecoration(
              contentPadding:EdgeInsets.all(0),
              prefixIcon: Icon(Icons.search,color: Colors.deepPurple,size: 20),
              prefixIconConstraints: BoxConstraints(
                  maxHeight: 20,
                  minWidth: 25
              ),
              border: InputBorder.none,
              hintText: 'Search'
          ),
        ));
  }
}