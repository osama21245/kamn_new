// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LiveStreamChatModel {
  final String id;
  final String uid;
  final String username;
  final String message;
  LiveStreamChatModel({
    required this.id,
    required this.uid,
    required this.username,
    required this.message,
  });

  LiveStreamChatModel copyWith({
    String? id,
    String? uid,
    String? username,
    String? message,
  }) {
    return LiveStreamChatModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      username: username ?? this.username,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'username': username,
      'message': message,
    };
  }

  factory LiveStreamChatModel.fromMap(Map<String, dynamic> map) {
    return LiveStreamChatModel(
      id: map['id'] as String,
      uid: map['uid'] as String,
      username: map['username'] as String,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LiveStreamChatModel.fromJson(String source) =>
      LiveStreamChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LiveStreamChatModel(id: $id, uid: $uid, username: $username, message: $message)';
  }

  @override
  bool operator ==(covariant LiveStreamChatModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.uid == uid &&
        other.username == username &&
        other.message == message;
  }

  @override
  int get hashCode {
    return id.hashCode ^ uid.hashCode ^ username.hashCode ^ message.hashCode;
  }
}
