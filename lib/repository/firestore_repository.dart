import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hero/models/models.dart';
import 'package:hero/repository/storage_repository.dart';

class FirestoreRepository {
  final String? id;
  final String? stingrayId;
  final String? voteId;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  FirestoreRepository({this.id, this.stingrayId, this.voteId});

  Future updateUserData(
    String? id,
    String name,
    int age,
    String bio,
    List<String> imageUrls,
    List<String> interests,
    String jobTitle,
    bool isStingray,
    Team? team,
    String? email,
    int? instigations,
    int? votes,
    int? votesUsable,
    bool? isRude,
    List<dynamic> stingrays,
    bool finishedOnboarding,
  ) async {
    return await userCollection.doc(id).set({
      'id': id,
      'name': name,
      'age': age,
      'imageUrls': imageUrls,
      'interests': interests,
      'bio': bio,
      'jobTitle': jobTitle,
      'isStingray': isStingray,
      'email': email,
      'team': team,
      'instigations': instigations,
      'votes': votes,
      'votesUsable': votesUsable,
      'isRude': isRude,
      'stingrays': stingrays,
      'finishedOnboarding': finishedOnboarding,
    });
  }

  List<User?> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map<User?>((doc) {
      return User(
        id: doc['id'] ?? '',
        name: doc['name'] ?? '',
        age: doc['age'] ?? '',
        imageUrls: doc['imageUrls'] ?? [],
        interests: doc['interests'] ?? [],
        jobTitle: doc['jobTitle'] ?? '',
        bio: doc['bio'] ?? '',
        isStingray: doc['isStingray'] ?? false,
        email: doc['email'] ?? '',
        team: doc['team'] ?? null,
        instigations: doc['instigations'] ?? 0,
        votes: doc['votes'] ?? 0,
        votesUsable: doc['votesUsable'] ?? 0,
        isRude: doc['isRude'] ?? false,
        stingrays: doc['stingrays'] ?? [],
        finishedOnboarding: doc['finishedOnboarding'] ?? false,
      );
    }).toList();
  }

  Stream<List<User?>> get users {
    return userCollection.snapshots().map<List<User?>>(_userListFromSnapshot);
  }

  Stream<List<User?>> get differentUsers {
    return userCollection
        .where('stingrays', whereNotIn: [stingrayId])
        .snapshots()
        .map<List<User?>>(_userListFromSnapshot);
  }

  User? _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
      id: snapshot['id'],
      name: snapshot['name'],
      age: snapshot['age'],
      imageUrls: snapshot['imageUrls'],
      interests: snapshot['interests'],
      jobTitle: snapshot['jobTitle'],
      bio: snapshot['bio'],
      isStingray: snapshot['isStingray'],
      email: snapshot['email'],
      team: snapshot['team'],
      instigations: snapshot['instigations'],
      votes: snapshot['votes'],
      votesUsable: snapshot['votesUsable'],
      isRude: snapshot['isRude'],
      stingrays: snapshot['stingrays'],
      finishedOnboarding: snapshot['finishedOnboarding'],
    );
  }

  User _userDataFromSnapshotForBloc(DocumentSnapshot snapshot) {
    return User(
      id: snapshot['id'],
      name: snapshot['name'],
      age: snapshot['age'],
      imageUrls: snapshot['imageUrls'],
      interests: snapshot['interests'],
      jobTitle: snapshot['jobTitle'],
      bio: snapshot['bio'],
      isStingray: snapshot['isStingray'],
      email: snapshot['email'],
      team: snapshot['team'],
      instigations: snapshot['instigations'],
      votes: snapshot['votes'],
      votesUsable: snapshot['votesUsable'],
      isRude: snapshot['isRude'],
      stingrays: snapshot['stingrays'],
      finishedOnboarding: snapshot['finishedOnboarding'],
    );
  }

  Stream<User?> get userData {
    return userCollection.doc(id).snapshots().map(_userDataFromSnapshot);
  }

  Stream<User> getUser(String userId) {
    print('Getting user images from DB');
    return userCollection
        .doc(userId)
        .snapshots()
        .map(_userDataFromSnapshotForBloc);
  }

  ///stingrays

  Stream<List<Stingray?>> get stingrays {
    return FirebaseFirestore.instance
        .collection('stingrays')
        .snapshots()
        .map<List<Stingray?>>(_stingrayListFromSnapshot);
  }

  List<Stingray?> _stingrayListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map<Stingray?>((doc) {
      return Stingray(
        id: doc['id'] ?? '',
        name: doc['name'] ?? '',
        age: doc['age'] ?? '',
        imageUrls: doc['imageUrls'] ?? [],
        interests: doc['interests'] ?? [],
        jobTitle: doc['jobTitle'] ?? '',
        bio: doc['bio'] ?? '',
        isStingray: doc['isStingray'] ?? false,
        email: doc['email'] ?? '',
        team: doc['team'] ?? null,
        likes: _userFromMap(doc['likes'] ?? []),
        dislikes: doc['dislikes'] ?? [],
      );
    }).toList();
  }

  Future updateStingrayData(
    String? id,
    String name,
    int age,
    String bio,
    List<String> imageUrls,
    List<String> interests,
    String jobTitle,
    bool isStingray,
    Team? team,
    String? email,
    List<User?> likes,
    List<dynamic> dislikes,
  ) async {
    return await FirebaseFirestore.instance
        .collection('stingrays')
        .doc(id)
        .set({
      'id': id,
      'name': name,
      'age': age,
      'imageUrls': imageUrls,
      'interests': interests,
      'bio': bio,
      'jobTitle': jobTitle,
      'isStingray': isStingray,
      'email': email,
      'team': team,
      'likes': likes,
      'dislikes': dislikes,
    });
  }

  Stingray? _stingrayFromSnapshot(DocumentSnapshot snapshot) {
    return Stingray(
      id: snapshot['id'],
      name: snapshot['name'],
      age: snapshot['age'],
      imageUrls: snapshot['imageUrls'],
      interests: snapshot['interests'],
      jobTitle: snapshot['jobTitle'],
      bio: snapshot['bio'],
      isStingray: snapshot['isStingray'],
      email: snapshot['email'],
      team: snapshot['team'],
      likes: _userFromMap(snapshot['likes']),
      dislikes: snapshot['dislikes'],
    );
  }

  List<UserLiked?> _userFromMap(List<dynamic> mappedUsers) {
    List<UserLiked?> userList = [];
    for (Map<String, dynamic> user in mappedUsers) {
      userList.add(UserLiked(
        id: user['id'],
        name: user['name'],
        imageUrl: user['imageUrl'],
      ));
    }
    return userList;
  }

  Stream<Stingray?> get stingrayData {
    return FirebaseFirestore.instance
        .collection('stingrays')
        .doc(id!)
        .snapshots()
        .map(_stingrayFromSnapshot);
  }

  Future<void> updateStingrayLikes(String? id, User? user) async {
    return FirebaseFirestore.instance
        .collection('stingrays')
        .doc(id)
        // .update({'likes': user})
        .update({
          'likes': FieldValue.arrayUnion([UserLiked.toJson(user)])
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
//         final DocumentReference docRef = FirebaseFirestore.instance.collection("stingrays").doc(id);
// docRef.update({"likes": FieldValue.increment(1)});
  }

  Future<void> updateUserStinrayArray(String? id, String? stingrayId) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({
          'stingrays': FieldValue.arrayUnion([stingrayId])
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateBio(String? id, String bio) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'bio': bio})
        .then((value) => print("Bio Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateAge(String? id, int age) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'age': age})
        .then((value) => print("Age Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

    Future<void> updateGender(String? id, String gender) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'gender': gender})
        .then((value) => print("Gender Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateInterest(String? id, String interest) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({
          'interests': FieldValue.arrayUnion([interest])
        })
        .then((value) => print("Bio Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Object? voteEvent(String? voteId, int votesUsable) {
    try {
      if (votesUsable < 1) {
        throw Exception('You have no votes left!');
      }
      userCollection.doc(id).update({'votesUsable': FieldValue.increment(-1)});
      userCollection.doc(voteId).update({'votes': FieldValue.increment(1)});
      return null;
    } catch (e) {
      print(e);
      return e;
    }
  }

  @override
  Future<void> updateUserPictures(User user, String imageName) async {
    String downloadUrl =
        await StorageRepository().getDownloadURL(user, imageName);

    return userCollection.doc(user.id).update({
      'imageUrls': FieldValue.arrayUnion([downloadUrl])
    });
  }

  @override
  Future<void> updateUser(User user) async {
    return userCollection.doc(user.id).update(User.toJson(user)).then(
          (value) => print('User document updated.'),
        );
  }

    @override
  Stream<List<User>> getUsers(
    String userId,
  ) {
    return userCollection
        .where('stingrays', whereNotIn: [userId])
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => User.fromSnapshot(doc)).toList();
    });
  }


  
}
