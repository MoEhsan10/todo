import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:todo_app_v2/models/task_model.dart';

import '../models/user_model.dart';

class FirebaseFunction {
    static CollectionReference<TaskModel> getTasksCollection(String userId) =>
        getUsersCollection().doc(userId).collection('tasks')
        .withConverter<TaskModel>(
        fromFirestore: (docSnapshot, options) => TaskModel.fromJson(docSnapshot.data()!),
        toFirestore: (taskModel, _) => taskModel.toJson(),
    );

  static CollectionReference<UserModel> getUsersCollection() =>
      FirebaseFirestore.instance.collection('users')
          .withConverter<UserModel>(
        fromFirestore: (docSnapshot, options) => UserModel.fromJson(docSnapshot.data()!),
        toFirestore: (userModel, _) => userModel.toJson(),
      );

  static Future<void> addTaskToFireStore(TaskModel task,String userId) {
    CollectionReference<TaskModel> taskCollection = getTasksCollection(userId);
    DocumentReference<TaskModel> doc = taskCollection.doc();
    task.id=doc.id;
    return doc.set(task);
  }

  static Future<List<TaskModel>> getTasksFromFireStore(String userId) async {
    CollectionReference<TaskModel> taskCollection = getTasksCollection(userId);
     QuerySnapshot<TaskModel> querySnapshot = await taskCollection.get();
     return  querySnapshot.docs.map((docSnapShot) => docSnapShot.data(),).toList();
  }

  static Future<void> deleteTaskFromFireStore(String taskId,String userId)async {
    CollectionReference<TaskModel> taskCollection = getTasksCollection(userId);
   return taskCollection.doc(taskId).delete();
  }


  static Future<UserModel> register({
   required String fullName,
   required String userName,
   required String email,
   required String password,
   required String rePassword,
  })
  async{
   UserCredential credential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
   UserModel user = UserModel(
       id: credential.user!.uid,
       fullName: fullName,
       userName: userName,
       email: email,
   );
   CollectionReference<UserModel> userCollection = getUsersCollection();
   userCollection.doc(user.id).set(user);
   return user;
  }


  static Future<UserModel> login({
    required String email,
    required String password,
  })
  async{
   UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
   CollectionReference<UserModel> userCollection = getUsersCollection();
   DocumentSnapshot<UserModel> docSnapshot = await userCollection.doc(credential.user!.uid).get();
  return docSnapshot.data()!;
  }

 static Future<void> logout() => FirebaseAuth.instance.signOut();
//

  static Future<void> deleteTaskFromFireStore(String taskId)async {
    CollectionReference<TaskModel> taskCollection = getTasksCollection();
   return taskCollection.doc(taskId).delete();
  }

}
