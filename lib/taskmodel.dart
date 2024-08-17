class TaskModel {
  String title;
  String supTitle;
  String id;
  int date;
  bool isDone;
  String userId;

  TaskModel(
      {required this.title,
      required this.supTitle,
      this.id = "",
      required this.date,
      this.isDone = false,
      required this.userId});

  TaskModel.fromJason(Map<String, dynamic> jason)
      : this(
          title: jason["title"],
          supTitle: jason["supTitle"],
          date: jason["date"],
          id: jason["id"],
          userId: jason["userId"],
          isDone: jason["isDone"],
        );

  Map<String, dynamic> toJason() {
    return {
      "title": title,
      "supTitle": supTitle,
      "date": date,
      "id": id,
      "isDone": isDone,
      "userId": userId
    };
  }
}
