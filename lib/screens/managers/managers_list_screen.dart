import 'package:fios/providers/managers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManagersListScreen extends StatelessWidget {
  static final routeName = 'managers_list';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 40.0),
          Column(
            children: <Widget>[
              Text('All Managers'),
            ],
          ),
          Consumer<Managers>(
            builder: (context, data, child) {
              if (data.managers.length == 0) {
                return Center(child: Text('No data'));
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: data.managers.length,
                  itemBuilder: (_, int index) {
                    final manager = data.managers[index];
                    return ListTile(
                      title: Text(manager.name),
                    );
                  },
                ),
              );
            },
            child: Text('no'),
          ),
        ],
      ),
    );
  }
}
