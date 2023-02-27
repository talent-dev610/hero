import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool hasActions;

  const TopAppBar({
    Key? key,
    required this.title,
    this.hasActions = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('assets/valentine.png'),
              height: 50,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ],
      ),
      actions: hasActions
          ? [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/matches');
                  },
                  icon: Icon(Icons.message,
                      color: Theme.of(context).primaryColor)),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  icon: Icon(Icons.person,
                      color: Theme.of(context).primaryColor)),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
