import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo2/models/job.dart';
import 'package:flutter_demo2/services/firestore_service.dart';

import 'api_path.dart';

abstract class DataBase {
  Future<void> setJob(Job job);
  Future<void> deleteJob (Job job);
  Stream<List<Job>> jobsStream();
}

String documentIdFormCurrentDate () => DateTime.now().toIso8601String();

class FireStoreDatabase implements DataBase {
  FireStoreDatabase({@required this.uId}) : assert(uId != null);
  final String uId;

  final _service = FireStoreService.instance;

  @override
  Future<void> setJob(Job job)async => await _service.setData(
        path: ApiPath.job(uId, job.id),
        data: job.toMap(),
      );

  @override
  Future<void> deleteJob (Job job)=>_service.deleteData(path: ApiPath.job(uId, job.id));

  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: ApiPath.jobs(uId),
        builder: (data ,documentId) => Job.fromMap(data, documentId),
      );
}
