import 'package:flutter/material.dart';

class ModelCard extends StatefulWidget {
  const ModelCard(
      {super.key,
      required this.name,
      required this.imagePath,
      required this.isFavorite});
  final String name;
  final String imagePath;
  final bool isFavorite;
  @override
  State<ModelCard> createState() => _ModelCardState();
}

class _ModelCardState extends State<ModelCard> {
  @override
  Widget build(BuildContext context) {
    return const ListTile();
  }
}
