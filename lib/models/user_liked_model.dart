import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'models.dart';

class UserLiked extends Equatable {
  final String? id;
  final String name;
  final String imageUrl;

  UserLiked({required this.id, required this.name, required this.imageUrl});

  @override
  List<Object?> get props => [id, name, imageUrl];

  static Map<String, dynamic> toJson(User? userLiked) => {
        'id': userLiked?.id,
        'name': userLiked?.name,
        'imageUrl': userLiked?.imageUrls[0],
      };

  List<UserLiked?> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return UserLiked(
        name: dataMap['name'],
        imageUrl: dataMap['imageUrl'],
        id: dataMap['id'],
      );
    }).toList();
  }
}
