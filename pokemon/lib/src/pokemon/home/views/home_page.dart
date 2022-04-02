import 'package:flutter/material.dart';

import 'package:pokemon/src/pokemon/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/allPokemons';

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PokedexAppBar(
          bottom: PokedexTabBar(),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}
