import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_v2/models/task_model.dart';

class FirebaseFunction {
  static CollectionReference<TaskModel> getTasksCollection() =>
      FirebaseFirestore.instance.collection('tasks')
      .withConverter<TaskModel>(
      fromFirestore: (docSnapshot, options) => TaskModel.fromJson(docSnapshot.data()!),
      toFirestore: (taskModel, _) => taskModel.toJson() ,
  );

  static Future<void> addTaskToFireStore(TaskModel task) {
    CollectionReference<TaskModel> taskCollection = getTasksCollection();
    DocumentReference<TaskModel> doc = taskCollection.doc();
    task.id=doc.id;
    return doc.set(task);
  }

  static Future<List<TaskModel>> getTasksFromFireStore() async {
    CollectionReference<TaskModel> taskCollection = getTasksCollection();
     QuerySnapshot<TaskModel> querySnapshot = await taskCollection.get();
     return  querySnapshot.docs.map((docSnapShot) => docSnapShot.data(),).toList();
  }

  static Future<void> deleteTaskFromFireStore(String taskId)async {
    CollectionReference<TaskModel> taskCollection = getTasksCollection();
   return taskCollection.doc(taskId).delete();
  }
}
