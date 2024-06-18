class ToDoModel {
  int? id;
  String title;
  String description;
  String dateTime;
  ToDoModel(
      {this.id,required this.dateTime, required this.description, required this.title});

    // Convert a ToDoModel into a Map.
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'description': description,
      'dateTime': dateTime,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Extract a ToDoModel from a Map.
  factory ToDoModel.fromMap(Map<String, dynamic> map) {
    return ToDoModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dateTime: map['dateTime'],
    );
  }
}    

