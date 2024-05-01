// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LiveStreamingModel {
  final String title;
  final String image;
  final String uid;
  final String username;
  final int viewers;
  final String channelId;
  final DateTime startedAt;
  LiveStreamingModel({
    required this.title,
    required this.image,
    required this.uid,
    required this.username,
    required this.viewers,
    required this.channelId,
    required this.startedAt,
  });

  LiveStreamingModel copyWith({
    String? title,
    String? image,
    String? uid,
    String? username,
    int? viewers,
    String? channelId,
    DateTime? startedAt,
  }) {
    return LiveStreamingModel(
      title: title ?? this.title,
      image: image ?? this.image,
      uid: uid ?? this.uid,
      username: username ?? this.username,
      viewers: viewers ?? this.viewers,
      channelId: channelId ?? this.channelId,
      startedAt: startedAt ?? this.startedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'image': image,
      'uid': uid,
      'username': username,
      'viewers': viewers,
      'channelId': channelId,
      'startedAt': startedAt.millisecondsSinceEpoch,
    };
  }

  factory LiveStreamingModel.fromMap(Map<String, dynamic> map) {
    return LiveStreamingModel(
      title: map['title'] as String,
      image: map['image'] as String,
      uid: map['uid'] as String,
      username: map['username'] as String,
      viewers: map['viewers'] as int,
      channelId: map['channelId'] as String,
      startedAt: DateTime.fromMillisecondsSinceEpoch(map['startedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory LiveStreamingModel.fromJson(String source) =>
      LiveStreamingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LiveStreamingModel(title: $title, image: $image, uid: $uid, username: $username, viewers: $viewers, channelId: $channelId, startedAt: $startedAt)';
  }

  @override
  bool operator ==(covariant LiveStreamingModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.image == image &&
        other.uid == uid &&
        other.username == username &&
        other.viewers == viewers &&
        other.channelId == channelId &&
        other.startedAt == startedAt;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        image.hashCode ^
        uid.hashCode ^
        username.hashCode ^
        viewers.hashCode ^
        channelId.hashCode ^
        startedAt.hashCode;
  }
}
