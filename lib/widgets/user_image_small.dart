import 'package:flutter/material.dart';

class UserImagesSmall extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  const UserImagesSmall({
    Key? key,
    required this.imageUrl,
    this.height = 60,
    this.width = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 8,
        right: 8,
      ),
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
