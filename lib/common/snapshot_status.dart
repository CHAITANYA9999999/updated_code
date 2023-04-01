import 'package:flutter/material.dart';
import 'package:punchmepartner/res/app_styles.dart';

class SnapshotEmpty extends StatelessWidget {
  const SnapshotEmpty(this.text);
  final text;

  @override
  Widget build(BuildContext context) {
    return Center(
        child:
            Text(text, textAlign: TextAlign.center, style: AppStyles.idleTxt));
  }
}

class SnapshotLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class SnapshotError extends StatelessWidget {
  final String text;

  const SnapshotError({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(text == '' ? 'Something went wrong...' : text,
            textAlign: TextAlign.center, style: AppStyles.idleTxt));
  }
}
