import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String? id;
  final int? index;
  final String? title;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  const Todo({
    this.id,
    this.index,
    this.title,
    this.createdAt,
    this.updatedAt,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String?,
      title: json['title'] as String?,
      index: json['index'] as int?,
      createdAt: json['created_at'] as Timestamp?,
      updatedAt: json['updated_at'] as Timestamp?,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['index'] = index;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  Todo copyWith({
    String? id,
    int? index,
    String? title,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      index: index ?? this.index,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, index, title, createdAt, updatedAt];
}
