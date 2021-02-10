import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 0)
class TodoModel extends Equatable with HiveObject {
  @HiveField(0)
  final String task;
  @HiveField(1)
  final String fromTime;
  @HiveField(2)
  final String toTime;
  @HiveField(3)
  final String date;

  TodoModel({
    this.fromTime,
    this.toTime,
    this.date,
    this.task,
  });

  @override
  List<Object> get props => [task, fromTime, toTime, date];

  @override
  bool get stringify => true;
}
