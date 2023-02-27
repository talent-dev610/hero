import 'package:equatable/equatable.dart';
import 'package:hero/models/user_model.dart';

class Team extends Equatable {
  final int id;
  final String name;
  final int age;
  final String imageUrls;
  final String charity;
  final String description;
  final bool isStingray;
  final List<User>? members;
  final String charityImgUrl;

  const Team(
      {required this.id,
      required this.name,
      required this.age,
      required this.imageUrls,
      required this.charity,
      required this.description,
      required this.members,
      this.isStingray = false,
      this.charityImgUrl =
          'https://upload.wikimedia.org/wikipedia/commons/4/48/BLANK_ICON.png'});

  @override
  List<Object?> get props =>
      [id, name, age, imageUrls, charity, description, isStingray];

  static List<Team> teams = [
    Team(
      id: 1,
      name: 'WVU Paws',
      age: 22,
      imageUrls:
          'https://iserve.wvu.edu/content/iserve.wvu.edu/agency/51060.jpg?1630799938?area=agency',
      description: 'Waifu',
      charity: 'First girl, best girl',
      members: [User.users[0]],
      charityImgUrl:
          'https://www.animalcharityofohio.org/uploads/7/0/1/5/70153949/published/animal-charity-logo-1.png?1642682971',
    ),
    Team(
      id: 2,
      name: 'Plant Club',
      age: 30,
      imageUrls: 'https://i.imgur.com/lrBq6dk.jpg',
      description: 'Nihilist',
      charity: "We're all gonna make it",
      members: [User.users[0]],
      charityImgUrl:
          'https://watchandlearn.scholastic.com/content/dam/classroom-magazines/watchandlearn/videos/animals-and-plants/plants/what-are-plants-/What-Are-Plants.jpg',
    ),
    Team(
      id: 3,
      name: 'WVU Swim Club',
      age: 9000,
      imageUrls:
          'https://pbs.twimg.com/profile_images/1288113026013384715/yuPtwwR3_400x400.jpg',
      description: 'Dancer',
      members: [User.users[0]],
      charity: 'bro cmon now',
    ),
    Team(
      id: 4,
      name: 'Film Club',
      age: 30,
      imageUrls:
          'https://scontent-iad3-1.xx.fbcdn.net/v/t31.18172-8/22254712_1718180864881548_9167503100642808321_o.jpg?stp=dst-jpg_s960x960&_nc_cat=100&ccb=1-5&_nc_sid=8631f5&_nc_ohc=KMWuZIngKJIAX8Z_Wy0&_nc_ht=scontent-iad3-1.xx&oh=00_AT8A5WrEp5_xqG0_Gob9Ifx7ZfqiHZBS6btaDErVgEpjVQ&oe=624676A0',
      description: 'Freedom fighter',
      charity: 'Kept ya waiting, huh',
      members: [User.users[0]],
    ),
    Team(
      id: 5,
      name: 'Phi Sigma Pi',
      age: 35,
      imageUrls:
          'https://phisigmapi.org/sites/default/files/2017-07/PSP_Shield_4c.png',
      description: 'Target',
      charity: 'Daaaaaaaaaaaaaaang danny',
      members: [User.users[0]],
    ),
    Team(
      id: 6,
      name: 'Student Grotto',
      age: 35,
      imageUrls:
          'https://pbs.twimg.com/profile_images/378800000835134809/321c7e513a1de90b834b930a636e6d1a_400x400.jpeg',
      description: 'Job Title Here',
      charity:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
      members: [User.users[0]],
    ),
    Team(
      id: 7,
      name: 'Outdoor Adventure Club',
      age: 35,
      imageUrls:
          'https://www.wboy.com/wp-content/uploads/sites/43/2019/08/TopAdventureTowns_WINNER.png',
      description: 'Job Title Here',
      charity:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
      members: [User.users[0]],
    ),
    Team(
      id: 8,
      name: 'WVU Safety Squad',
      age: 35,
      imageUrls:
          'https://pbs.twimg.com/profile_images/1233227029572673536/q2uvz591_400x400.jpg',
      description: 'Job Title Here',
      charity:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
      members: [User.users[0]],
    ),
    Team(
      id: 9,
      name: 'Airsoft Club',
      age: 35,
      imageUrls:
          'https://se-images.campuslabs.com/clink/images/26bd0d55-9c81-4217-abaf-be68f7e4abc946f53391-a717-4174-94f8-a402428234db.png?preset=med-sq',
      description: 'Job Title Here',
      members: [User.users[0]],
      charity:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    Team(
      id: 10,
      name: 'WV United',
      age: 35,
      imageUrls:
          'https://upload.wikimedia.org/wikipedia/en/thumb/b/bc/WVU_club_logo.png/190px-WVU_club_logo.png',
      description: 'Job Title Here',
      members: [User.users[0]],
      charity:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    Team(
      id: 11,
      name: 'Ryuko Matoi Fan Club',
      age: 35,
      imageUrls:
          'https://i.pinimg.com/originals/c4/86/9e/c4869edff3fe8b3cead7eb566ac633af.png',
      description: 'Job Title Here',
      members: [User.users[0]],
      charity:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
  ];
}
