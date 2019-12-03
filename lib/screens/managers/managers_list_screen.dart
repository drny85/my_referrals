import 'package:fios/models/manager.dart';
import 'package:fios/models/referee.dart';
import 'package:fios/providers/managers.dart';
import 'package:fios/providers/referees.dart';
import 'package:fios/screens/managers/manager_detail.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManagersListScreen extends StatefulWidget {
  static final routeName = 'managers_list';

  final String type;

  ManagersListScreen(this.type);

  @override
  _ManagersListScreenState createState() => _ManagersListScreenState();
}

class _ManagersListScreenState extends State<ManagersListScreen> {
  String name = '';
  String lastName = '';
  String phone = '';
  String email = '';
  String title = '';
  void _addManager() async {
    if (widget.type == 'manager') {
      if (name == '' || lastName == '' || phone == '' || email == '') {
        return;
      }
      final manager =
          Manager(lastName: lastName, phone: phone, name: name, email: email);
      print(manager.phone);
      await Provider.of<Managers>(context)
          .addManager(manager: manager)
          .then((success) {
        if (success) {
          Navigator.pop(context);
        }
      });
    }

    if (widget.type == 'referee') {
      if (name == '' || lastName == '' || phone == '' || email == '') {
        return;
      }
      final referee =
          Referee(lastName: lastName, phone: phone, name: name, email: email);
      print(referee.phone);
      await Provider.of<Referees>(context)
          .addReferee(referee: referee)
          .then((success) {
        if (success) {
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkForType();
  }

  void _checkForType() {
    if (widget.type == 'manager') {
      setState(() {
        title = 'Managers';
      });
    }

    if (widget.type == 'referee') {
      setState(() {
        title = 'Referees';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 40.0),
          Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 28.0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'All $title',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                insetAnimationCurve: Curves.bounceInOut,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0)),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Color(0xff737373),
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 12.0),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Spacer(),
                                              Text(
                                                'Add ${widget.type}'
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    fontSize: 22.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Spacer(),
                                              RaisedButton(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                child: Text(
                                                  'Save',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onPressed: _addManager,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 12.0,
                                          ),
                                          TextField(
                                            autofocus: true,
                                            textCapitalization:
                                                TextCapitalization.words,
                                            onChanged: (value) {
                                              setState(() {
                                                name = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Name',
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          TextField(
                                            autofocus: true,
                                            textCapitalization:
                                                TextCapitalization.words,
                                            onChanged: (value) {
                                              setState(() {
                                                lastName = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Last Name',
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          TextField(
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            autocorrect: false,
                                            textCapitalization:
                                                TextCapitalization.none,
                                            onChanged: (value) {
                                              setState(() {
                                                email = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Email',
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          TextField(
                                            keyboardType: TextInputType.phone,
                                            onChanged: (value) {
                                              setState(() {
                                                phone = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Phone',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                elevation: 5.0,
                              );
                            });
                      },
                      child: CircleAvatar(
                        radius: 25.0,
                        child: Icon(
                          Icons.add,
                          size: 28.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          widget.type == 'manager'
              ? Consumer<Managers>(
                  builder: (_, data, __) {
                    if (data.managers.length == 0) {
                      return Center(child: Text('No data'));
                    }

                    return Expanded(
                      child: ListView.builder(
                        itemCount: data.managers.length,
                        padding: const EdgeInsets.all(4.0),
                        itemBuilder: (_, int index) {
                          final manager = data.managers[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ManagerDetailScreen(
                                        manager: manager,
                                        type: widget.type,
                                      ),
                                    ));
                              },
                              leading: CircleAvatar(
                                child: Image.asset('assets/images/profile.png'),
                                radius: 45.0,
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                              title: Text('${manager.name} ${manager.lastName}'
                                  .toUpperCase()),
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              : Consumer<Referees>(
                  builder: (_, data, __) {
                    if (data.referees.length == 0) {
                      return Center(child: Text('No data'));
                    }

                    return Expanded(
                      child: ListView.builder(
                        itemCount: data.referees.length,
                        padding: const EdgeInsets.all(4.0),
                        itemBuilder: (_, int index) {
                          final referee = data.sortedReferees[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ManagerDetailScreen(
                                        manager: referee,
                                        type: widget.type,
                                      ),
                                    ));
                              },
                              leading: CircleAvatar(
                                child: Image.asset('assets/images/profile.png'),
                                radius: 45.0,
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                              title: Text('${referee.name} ${referee.lastName}'
                                  .toUpperCase()),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
