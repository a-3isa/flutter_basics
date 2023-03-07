import 'package:flutter/material.dart';
import 'package:new_basics/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Password Reset',
    content: 'Reset Massage has been sent',
    optionBuilder: () => {
      'OK': null,
    },
  );
}
