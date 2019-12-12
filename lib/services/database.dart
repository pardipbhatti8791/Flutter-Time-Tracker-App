import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

import 'package:timer_tracker/app/home/models/job.dart';
import 'package:timer_tracker/services/api_path.dart';

abstract class Database {
  Future<void> createJob(Job job);
  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase implements Database {
  final String uid;
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  Future<void> createJob(Job job) async =>
      await _setData(path: APIPath.job(uid, 'job_abc'), data: job.toMap());

  Stream<List<Job>> jobsStream() => _collectionStream(
      path: APIPath.jobs(uid), builder: (data) => Job.fromMap(data));

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final reference = Firestore.instance.document(path);
    print('$path: $data');
    await reference.setData(data);
  }

  Stream<List<T>> _collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data),
  }) {
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map(
      (snapshot) =>
          snapshot.documents.map((snapshot) => builder(snapshot.data)).toList(),
    );
  }
}
