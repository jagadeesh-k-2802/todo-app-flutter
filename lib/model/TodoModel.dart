class TodoModel {
  int id;
  String todo;
  bool isCompleted;

  TodoModel({this.id, this.todo, this.isCompleted = false});

  @override
  String toString() {
    super.toString();
    return "Todo($id, $todo, $isCompleted)";
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todo': todo,
      'isCompleted': isCompleted == false ? 0 : 1,
    };
  }

  TodoModel.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.todo = map['todo'];
    this.isCompleted = (map['isCompleted'] as int) == 0 ? false : true;
  }
}
