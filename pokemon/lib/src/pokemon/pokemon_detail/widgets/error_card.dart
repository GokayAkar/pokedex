import 'package:flutter/material.dart';

class PokemonErrorCard extends StatelessWidget {
  final String errorText;
  final VoidCallback onTap;
  final MainAxisAlignment mainAxisAlignment;
  const PokemonErrorCard({
    required this.errorText,
    this.mainAxisAlignment = MainAxisAlignment.spaceAround,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(errorText),
        IconButton(
          icon: const Icon(Icons.replay_outlined),
          onPressed: onTap,
        )
      ],
    );
  }
}
