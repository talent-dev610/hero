import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'team_model.dart';

class User extends Equatable {
  final String? id;
  final String name;
  final int age;
  final List<dynamic> imageUrls;
  final List<dynamic> interests;
  final String bio;
  final String jobTitle;
  final bool isStingray;
  final String? email;
  final Team? team;
  final int votes;
  final int votesUsable;
  final int instigations;
  final bool isRude;
  final List<dynamic> stingrays;
  final bool finishedOnboarding;

  const User({
    required this.id,
    required this.name,
    required this.age,
    required this.imageUrls,
    required this.interests,
    required this.bio,
    required this.jobTitle,
    this.isStingray = false,
    this.email = 'bruh',
    this.team = null,
    required this.instigations,
    required this.isRude,
    required this.votes,
    required this.votesUsable,
    required this.stingrays,
    required this.finishedOnboarding
  });

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        imageUrls,
        bio,
        jobTitle,
        isStingray,
        email,
        team,
        instigations,
        isRude,
        votes,
        votesUsable,
        stingrays,
        finishedOnboarding
      ];

  static Map<String, dynamic> toJson(User? user) => {
        'id': user?.id,
        'name': user?.name,
        'age': user?.age,
        'imageUrls': user?.imageUrls,
        'interests': user?.interests,
        'bio': user?.bio,
        'jobTitle': user?.jobTitle,
        'isStingray': user?.isStingray,
        'instigations': user?.instigations,
        'isRude': user?.isRude,
        'votes': user?.votes,
        'votesUsable': user?.votesUsable,
        'stingrays': user?.stingrays,
        'finishedOnboarding': user?.finishedOnboarding,
      };

        static User fromSnapshot(DocumentSnapshot snap) {
    User user = User(
             id: snap['id'] ?? '',
        name: snap['name'] ?? '',
        age: snap['age'] ?? '',
        imageUrls: snap['imageUrls'] ?? [],
        interests: snap['interests'] ?? [],
        jobTitle: snap['jobTitle'] ?? '',
        bio: snap['bio'] ?? '',
        isStingray: snap['isStingray'] ?? false,
        email: snap['email'] ?? '',
        team: snap['team'] ?? null,
        instigations: snap['instigations'] ?? 0,
        votes: snap['votes'] ?? 0,
        votesUsable: snap['votesUsable'] ?? 0,
        isRude: snap['isRude'] ?? false,
        stingrays: snap['stingrays'] ?? [],
        finishedOnboarding: snap['finishedOnboarding'] ?? false,

    );
    return user;
  }

      

  static List<User> users = [
    User(
      id: '1',
      name: 'Ryuko',
      age: 22,
      stingrays: [],
      finishedOnboarding: false,
      imageUrls: [
        'https://i.pinimg.com/originals/c4/86/9e/c4869edff3fe8b3cead7eb566ac633af.png',
        'https://i1.sndcdn.com/artworks-000659397541-b0ysqw-t500x500.jpg',
        'https://preview.redd.it/6s4xube9a6g61.jpg?width=640&crop=smart&auto=webp&s=3f27207da58bc03349c571c0de6e2b2677a4220d',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRj9k1_AgI9wH4UgbsKqTxBP681wyzjRLCHAQ&usqp=CAU',
        'https://i.kym-cdn.com/photos/images/original/001/397/065/e77.jpg',
        'https://i.kym-cdn.com/photos/images/original/001/397/065/e77.jpg',
        'https://i.kym-cdn.com/photos/images/original/001/397/065/e77.jpg',
        'https://i.kym-cdn.com/photos/images/original/001/397/065/e77.jpg',
      ],
      isRude: false,
      instigations: 0,
      votes: 0,
      votesUsable: 0,
      jobTitle: 'Waifu',
      bio: 'First girl, best girl',
      interests: ['Fighting', 'clothes', 'swords'],
      team: Team(
        id: 2,
        name: 'Plant Club',
        age: 30,
        imageUrls: 'https://i.imgur.com/lrBq6dk.jpg',
        description: 'Nihilist',
        charity: "We're all gonna make it",
        members: null,
        charityImgUrl:
            'https://watchandlearn.scholastic.com/content/dam/classroom-magazines/watchandlearn/videos/animals-and-plants/plants/what-are-plants-/What-Are-Plants.jpg',
      ),
    ),
    User(
      id: '2',
      name: 'Wojak',
      stingrays: [],
            finishedOnboarding: false,

      age: 30,
      imageUrls: [
        'https://i.kym-cdn.com/photos/images/newsfeed/001/874/171/b81.png',
        'https://www.meme-arsenal.com/memes/7abb23670703d98e127e9be1840d90d6.jpg',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRr1T_V_jtUGxeUYUOsOC_cR7eNKAj1b0HeVQ&usqp=CAU',
        'https://i.pinimg.com/736x/09/6b/cb/096bcbea4ed86f6abdb8dfb528f82e12.jpg',
        'https://i.kym-cdn.com/photos/images/newsfeed/000/852/499/cbb.jpg',
      ],
      isRude: false,
      instigations: 0,
      votes: 0,
      votesUsable: 0,
      jobTitle: 'Nihilist',
      interests: ['Investing', 'hating', 'seething'],
      bio: "We're all gonna make it",
    ),
    User(
      id: '3',
      name: 'Ankha',
      age: 9000,
            finishedOnboarding: false,

      isRude: false,
      instigations: 0,
      stingrays: [],
      votes: 0,
      votesUsable: 0,
      imageUrls: [
        'https://en.memesrandom.com/wp-content/uploads/2021/09/image-154.png',
        'https://i.kym-cdn.com/entries/icons/facebook/000/033/898/tempsnip8.jpg',
        'https://i.ytimg.com/vi/tlaPfNQrLYA/maxresdefault.jpg',
        'https://c.tenor.com/SrG3JgVtGYoAAAAC/ankha-animal.gif',
        'https://c.tenor.com/IklTihjpcdkAAAAC/ankha-ankha-animal-crossing.gif',
      ],
      jobTitle: 'Dancer',
      interests: ['Dancing', 'Zone', 'Animations'],
      bio: 'bro cmon now',
    ),
    User(
      id: '4',
      name: 'Big Boss',
      age: 30,
            finishedOnboarding: false,

      isRude: false,
      stingrays: [],
      instigations: 0,
      votes: 0,
      votesUsable: 0,
      imageUrls: [
        'https://static.wikia.nocookie.net/metalgear/images/e/e5/Maxresdefault.jpg/revision/latest?cb=20170216141548&path-prefix=pt',
        'https://i.ytimg.com/vi/CrfVKNONoPk/maxresdefault.jpg',
        'https://i.pinimg.com/originals/91/4c/c9/914cc990c7bd0ba5d8b775ebe4426f9a.jpg',
        'https://www.gameinformer.com/s3/files/styles/body_default/s3/legacy-images/imagefeed/A%20Newcomer%27s%20Guide%20To%20Big%20Boss/bigboss610.jpg',
        'https://i.pinimg.com/originals/b2/ae/d9/b2aed9f239dd5b408ee553185bac6058.jpg',
      ],
      jobTitle: 'Freedom fighter',
      interests: ['Fighting', 'Quiet', 'guns'],
      bio: 'Kept ya waiting, huh',
    ),
    User(
      id: '5',
      name: 'Damned Daniel',
      age: 35,
            finishedOnboarding: false,

      isRude: false,
      stingrays: [],
      instigations: 0,
      votes: 0,
      votesUsable: 0,
      imageUrls: [
        'https://preview.redd.it/tufnu8o53w401.jpg?auto=webp&s=195c6159ba9232884decc154898592e36bc94118',
        'https://api.ellecanada.com/app/uploads/2016/02/0cc95083-baaa-42ae-b735-2c7cc2538e45-damn-daniel.jpg',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5oAQ_XJukVuuTZ3z0o5OkBanRUaVCK5P87A&usqp=CAU',
        'https://64.media.tumblr.com/02a1c6af803e90eff25219bbdb59011d/977ca14aee3b4436-4a/s1280x1920/eac6b28cc92f1907c76691cbc7d0f3166b712076.jpg',
        'https://i1.sndcdn.com/artworks-000634958347-fhnal6-t500x500.jpg',
      ],
      jobTitle: 'Target',
      interests: ['Vans', 'Warcrimes', 'Salad Snake'],
      bio: 'Daaaaaaaaaaaaaaang danny',
    ),
    User(
      id: '6',
      isRude: false,
      instigations: 0,
            finishedOnboarding: false,

      votes: 0,
      stingrays: [],
      votesUsable: 0,
      name: 'Lisa',
      age: 35,
      imageUrls: [
        'https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Fighting', 'clothes', 'swords'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      isRude: false,
      instigations: 0,
            finishedOnboarding: false,

      votes: 0,
      votesUsable: 0,
      stingrays: [],
      id: '7',
      name: 'Luisa',
      age: 35,
      imageUrls: [
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Fighting', 'clothes', 'swords'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      isRude: false,
      instigations: 0,
      votes: 0,
      votesUsable: 0,
            finishedOnboarding: false,

      stingrays: [],
      id: '8',
      name: 'Sara',
      age: 35,
      imageUrls: [
        'https://images.unsplash.com/photo-1589571894960-20bbe2828d0a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80',
        'https://images.unsplash.com/photo-1589571894960-20bbe2828d0a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80',
        'https://images.unsplash.com/photo-1589571894960-20bbe2828d0a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80',
        'https://images.unsplash.com/photo-1589571894960-20bbe2828d0a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80',
        'https://images.unsplash.com/photo-1589571894960-20bbe2828d0a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Fighting', 'clothes', 'swords'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      isRude: false,
      instigations: 0,
      votes: 0,
            finishedOnboarding: false,

      votesUsable: 0,
      stingrays: [],
      id: '9',
      name: 'Andrea',
      age: 35,
      imageUrls: [
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Fighting', 'clothes', 'swords'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      isRude: false,
      instigations: 0,
      votes: 0,
            finishedOnboarding: false,

      stingrays: [],
      votesUsable: 0,
      id: '10',
      name: 'Mary',
      age: 35,
      imageUrls: [
        'https://images.unsplash.com/photo-1456885284447-7dd4bb8720bf?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1456885284447-7dd4bb8720bf?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1456885284447-7dd4bb8720bf?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1456885284447-7dd4bb8720bf?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1456885284447-7dd4bb8720bf?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Fighting', 'clothes', 'swords'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      isRude: false,
      instigations: 0,
            finishedOnboarding: false,

      votes: 0,
      stingrays: [],
      votesUsable: 0,
      id: '11',
      name: 'Denise',
      age: 35,
      imageUrls: [
        'https://images.unsplash.com/photo-1596815064285-45ed8a9c0463?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=615&q=80',
        'https://images.unsplash.com/photo-1596815064285-45ed8a9c0463?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=615&q=80',
        'https://images.unsplash.com/photo-1596815064285-45ed8a9c0463?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=615&q=80',
        'https://images.unsplash.com/photo-1596815064285-45ed8a9c0463?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=615&q=80',
        'https://images.unsplash.com/photo-1596815064285-45ed8a9c0463?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=615&q=80',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Fighting', 'clothes', 'swords'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
  ];
}
