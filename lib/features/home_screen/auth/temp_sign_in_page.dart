import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/auth/temp_sign_in_provider.dart';
import 'package:vvault_redesign/main.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<SignInProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Column(
        children: <Widget>[
          TextField(controller: _loginController, decoration: InputDecoration(labelText: 'Login'), style: TextStyle(color: Colors.black),),
          TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password')),
          ElevatedButton(
            onPressed: () async {
              try {
                await userProvider.signIn(
                  _loginController.text,
                  _passwordController.text,
                );
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => NavBar()));
                print('вошел');
              } catch (e) {
                print(e);
              }
            },
            child: Text('Sign In'),
          ),
        ],
      ),
    );
  }
}