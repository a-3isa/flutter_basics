import 'package:flutter/material.dart';
import 'package:new_basics/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: 'an error occured',
    content: text,
    optionBuilder: () => {
      'OK': null,
    },
  );
}
