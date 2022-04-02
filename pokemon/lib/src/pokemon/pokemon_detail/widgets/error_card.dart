import 'package:flutter/material.dart';

class PokemonErrorCard extends StatelessWidget {
  final String errorText;
  final VoidCallback onTap;
  const PokemonErrorCard({required this.errorText, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
