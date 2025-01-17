import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveAlert {
  const AdaptiveAlert._();

  static Future<DateTime?> datePicker({
    required BuildContext context,
    required DateTime maximumDate,
    DateTime? initialDate,
    required String doneText,
  }) async {
    if (Platform.isIOS) {
      DateTime? pickedDate;
      await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            actions: [
              SizedBox(
                height: 180,
                child: CupertinoDatePicker(
                  onDateTimeChanged: (value) => pickedDate = value,
                  mode: CupertinoDatePickerMode.date,
                  maximumDate: maximumDate,
                  initialDateTime: initialDate,
                ),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text(doneText),
              onPressed: () => Navigator.pop(context),
            ),
          );
        },
      );

      return pickedDate;
    }

    return await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Theme.of(context).colorScheme.primary,
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
  }

  static Future<bool?> twoButtons({
    required BuildContext context,
    required Widget title,
    VoidCallback? onNoPressed,
    VoidCallback? onYesPressed,
    String? yesText,
  }) {
    if (!Platform.isIOS) {
      return showCupertinoDialog<bool>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: title,
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: onNoPressed,
              child: const Text('No', style: TextStyle(color: Colors.white)),
            ),
            CupertinoDialogAction(
              onPressed: onYesPressed,
              child: Text(
                yesText ?? 'Yes',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: title,
        actions: <Widget>[
          ElevatedButton(
            onPressed: onNoPressed,
            child: const Text('No', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: onYesPressed,
            child: Text(yesText ?? 'Yes'),
          ),
        ],
      ),
    );
  }

  static Future<void> error(
    BuildContext context, {
    required String title,
    required VoidCallback onPressed,
    String? body,
  }) {
    if (!Platform.isIOS) {
      return showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              // const Positioned(
              //   left: 1,
              //   bottom: 100,
              //   child: Icon(
              //     Icons.error,
              //     color: Colors.red,
              //     size: 44,
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.only(top: 45),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    // title
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    Text(body ?? ''),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: onPressed,
                          child: const Text(
                            'Ok',
                            style: TextStyle(fontSize: 16),
                          )),
                    ),
                  ],
                ),
              ),
              const Positioned(
                left: 20,
                bottom: 70,
                right: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 45,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 50,
                      )),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('ciao'),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: onPressed,
            child: const Text(
              'Ok',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> information(BuildContext context,
      {required Widget title,
      Widget content = const Text(''),
      required VoidCallback onPressed}) {
    if (!Platform.isIOS) {
      return showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: title,
          content: Stack(
            children: [
              content,
              const Positioned(
                left: 200,
                top: 0,
                bottom: 140,
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 42,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: onPressed,
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
    return showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: title,
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: onPressed,
            child: const Text(
              'Ok',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> thinLoading(BuildContext context) {
    if (!Platform.isIOS) {
      return showDialog<bool>(
        context: context,
        builder: (context) => const AlertDialog(
          actions: <Widget>[
            SizedBox(
              height: 60,
              child: Center(child: CircularProgressIndicator.adaptive()),
            ),
          ],
        ),
      );
    }
    return showCupertinoDialog<bool>(
      context: context,
      builder: (context) => const CupertinoAlertDialog(
        actions: <Widget>[
          SizedBox(
            height: 60,
            child: Center(child: CircularProgressIndicator.adaptive()),
          ),
        ],
      ),
    );
  }
}
