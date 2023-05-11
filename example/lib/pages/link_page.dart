// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class LinkPage extends StatelessWidget {
  const LinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          Link.underline(
            'Underline',
            onTap: () => print('underline'),
          ),
          Link.text(
            'Text',
            onTap: () => print('text'),
          ),
        ],
      ),
    );
  }
}
