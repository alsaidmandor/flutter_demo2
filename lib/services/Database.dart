import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo2/models/job.dart';
import 'package:flutter_demo2/services/firestore_service.dart';

import 'api_path.dart';

abstract class DataBase {
  Future<void> createJob(Job job);

  Stream<List<Job>> jobsStream();
}

class FireStoreDatabase implements DataBase {
  FireStoreDatabase({@required this.uId}) : assert(uId != null);
  final String uId;

  final _service = FireStoreService.instance;

  @override
  Future<void> createJob(Job job) => _service.setData(
        path: ApiPath.job(uId, 'job_abc'),
        data: job.toMap(),
      );

  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: ApiPath.jobs(uId),
        builder: (data) => Job.fromMap(data),
      );
}
