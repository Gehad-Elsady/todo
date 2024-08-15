import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/taskmodel.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, options) {
        return TaskModel.fromJason(snapshot.data()!);
      },
      toFirestore: (task, options) {
        return task.toJason();
      },
    );
  }

  static Future<void> addTask(TaskModel task) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<void> doneTask(TaskModel task) {
    return getTasksCollection().doc(task.id).update(task.toJason());
  }

  static Future<void> deleteTask(String id) {
    return getTasksCollection().doc(id).delete();
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime data) {
    var collection = getTasksCollection();
    return collection
        .where("date",
            isEqualTo: DateUtils.dateOnly(data).microsecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> updateTask(TaskModel task) {
    return getTasksCollection().doc(task.id).update(task.toJason());
  }
}
