import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/Models/taskmodel.dart';
import 'package:todo/Models/user-model.dart';

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
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date",
            isEqualTo: DateUtils.dateOnly(data).microsecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> updateTask(TaskModel task) {
    return getTasksCollection().doc(task.id).update(task.toJason());
  }

  static SignUp(String emailAddress, String password,
      {required Function onSuccess,
      required Function onError,
      required String userName,
      required String phoneNumber,
      required int age}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      credential.user?.sendEmailVerification();
      UserModel userModel = UserModel(
        age: age,
        email: emailAddress,
        name: userName,
        phone: phoneNumber,
        id: credential.user!.uid,
      );
      addUser(userModel);

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    } catch (e) {
      print(e);
    }
  }

  static Login(
    String emailAddress,
    String password, {
    required Function onSuccess,
    required Function onError,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    }
  }

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, options) {
        return UserModel.fromJason(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJason();
      },
    );
  }

  static Future<void> addUser(UserModel user) {
    var collection = getUserCollection();
    var docRef = collection.doc(user.id);
    return docRef.set(user);
  }

  static signOut() {
    FirebaseAuth.instance.signOut();
  }

  static Stream<List<String>> getUserNames() {
    var collection = getUserCollection();
    return collection.snapshots().map(
        (snapshot) => snapshot.docs.map((doc) => doc.data().name).toList());
  }
}
