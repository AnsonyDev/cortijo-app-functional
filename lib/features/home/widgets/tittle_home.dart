import 'package:flutter/material.dart';

class TittleHome extends StatelessWidget {
  const TittleHome({
    required this.tittle,
    Key? key,
  }) : super(key: key);
  final String tittle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        tittle,
        style: const TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Quiza pro'),
      ),
    );
  }
}
