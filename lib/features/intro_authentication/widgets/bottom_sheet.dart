import 'package:flutter/material.dart';

PersistentBottomSheetController modalBottomSheet(
    BuildContext context, Widget child) {
  return showBottomSheet(
    enableDrag: false,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    context: context,
    builder: (_) => child,
  );
}
