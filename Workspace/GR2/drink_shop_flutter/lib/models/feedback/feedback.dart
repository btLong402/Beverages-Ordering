// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Feedback {
  final String feedbackId;
  final String feedback;
  final String productId;
  final String creator;
  final DateTime createAt;
  Feedback({
    required this.feedbackId,
    required this.feedback,
    required this.productId,
    required this.creator,
    required this.createAt,
  });

  Feedback copyWith({
    String? feedbackId,
    String? feedback,
    String? productId,
    String? creator,
    DateTime? createAt,
  }) {
    return Feedback(
      feedbackId: feedbackId ?? this.feedbackId,
      feedback: feedback ?? this.feedback,
      productId: productId ?? this.productId,
      creator: creator ?? this.creator,
      createAt: createAt ?? this.createAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'feedbackId': feedbackId,
      'feedback': feedback,
      'productId': productId,
      'creator': creator,
      'createAt': createAt.millisecondsSinceEpoch,
    };
  }

  factory Feedback.fromMap(Map<String, dynamic> map) {
    return Feedback(
      feedbackId: map['feedbackId'] as String,
      feedback: map['feedback'] as String,
      productId: map['productId'] as String,
      creator: map['creator'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Feedback.fromJson(String source) =>
      Feedback.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Feedback(feedbackId: $feedbackId, feedback: $feedback, productId: $productId, creator: $creator, createAt: $createAt)';
  }

  @override
  bool operator ==(covariant Feedback other) {
    if (identical(this, other)) return true;

    return other.feedbackId == feedbackId &&
        other.feedback == feedback &&
        other.productId == productId &&
        other.creator == creator &&
        other.createAt == createAt;
  }

  @override
  int get hashCode {
    return feedbackId.hashCode ^
        feedback.hashCode ^
        productId.hashCode ^
        creator.hashCode ^
        createAt.hashCode;
  }
}
