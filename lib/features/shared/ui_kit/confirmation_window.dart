import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmationWindow extends StatelessWidget {
  final String text;
  final String textForButton;
  final String textForButton2;
  final Function(BuildContext)? onPressed1;
  final Function(BuildContext)? onPressed2;

  const ConfirmationWindow({Key? key, required this.text, this.onPressed1, this.onPressed2, required this.textForButton, required this.textForButton2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,  // Dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF1D2126),  // Set the background color
          shape: RoundedRectangleBorder(  // Rounded corners in the dialog
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          title: Text(
            'Вы точно хотите удалить реквизиты 3243 2212 8873 3341?',  // The title text which is bold
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Отмена', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();  // Close the dialog
              },
            ),
            ElevatedButton(
              child: Text('Подтвердить', style: TextStyle(color: Colors.white)),
              onPressed: () {
                // Perform the action for confirmation
                Navigator.of(context).pop();  // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,  // Background color
              ),
            ),
          ],
        );
      },
    );
  }

}
