import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/p2p_market/provider/user_requisite_list/user_requisite_provider.dart';


class UserRequisiteScreen extends StatefulWidget {
  @override
  _UserRequisiteScreenState createState() => _UserRequisiteScreenState();
}

class _UserRequisiteScreenState extends State<UserRequisiteScreen> {




  @override
  void initState() {
    _loadData();
    super.initState();
  }

  void _loadData(){
    Provider.of<UserRequisiteProvider>(context, listen: false).loadRequisites();
  }

  @override
  Widget build(BuildContext context) {
    final requisites = Provider.of<UserRequisiteProvider>(context).requisites;

    return Scaffold(
      appBar: AppBar(title: Text('User Requisites')),
      body: ListView.builder(
        itemCount: requisites.length,
        itemBuilder: (context, index) {
          final requisite = requisites[index];

          return ListTile(
            title: Text(requisite['requisite']),
            subtitle: Text('${requisite['bank']} - ${requisite['comment']}'),
          );
        },
      ),
    );
  }
}
