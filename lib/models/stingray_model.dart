import 'package:equatable/equatable.dart';
import 'package:hero/models/models.dart';
import 'package:hero/models/user_model.dart';

import 'team_model.dart';

class Stingray extends Equatable {
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
  final List<UserLiked?> likes;
  final List<dynamic> dislikes;

  const Stingray(
      {required this.id,
      required this.name,
      required this.age,
      required this.imageUrls,
      required this.interests,
      required this.bio,
      required this.jobTitle,
      this.isStingray = false,
      this.email = 'bruh',
      this.team = null,
      required this.likes,
      required this.dislikes});

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
        likes,
        dislikes
      ];

  static List<Stingray> stingrays = [
    Stingray(
      id: '1',
      name: 'Ryuko',
      age: 22,
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
      likes: [],
      dislikes: [],
    ),
    Stingray(
      id: '2',
      name: 'Wojak',
      age: 30,
      imageUrls: [
        'https://i.kym-cdn.com/photos/images/newsfeed/001/874/171/b81.png',
        'https://www.meme-arsenal.com/memes/7abb23670703d98e127e9be1840d90d6.jpg',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRr1T_V_jtUGxeUYUOsOC_cR7eNKAj1b0HeVQ&usqp=CAU',
        'https://i.pinimg.com/736x/09/6b/cb/096bcbea4ed86f6abdb8dfb528f82e12.jpg',
        'https://i.kym-cdn.com/photos/images/newsfeed/000/852/499/cbb.jpg',
      ],
      jobTitle: 'Nihilist',
      interests: ['Investing', 'hating', 'seething'],
      bio: "We're all gonna make it",
      likes: [],
      dislikes: [],
    ),
    Stingray(
      id: '3',
      name: 'Ankha',
      age: 9000,
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
      likes: [],
      dislikes: [],
    ),
  ];
}
