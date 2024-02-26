class ToDo{
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone=false,
  });

  static List<ToDo> todoList(){
    return [
      ToDo(id:"01", todoText: "Flutter Tutorial",isDone: true),
      ToDo(id:"02", todoText: "java Tutorial"),
      ToDo(id:"03", todoText: "Android Tutorial",isDone: true),
      ToDo(id:"04", todoText: "Springboot Tutorial"),
      ToDo(id:"05", todoText: "React Tutorial",isDone: true),
    ];
  }
}