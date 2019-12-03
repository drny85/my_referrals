import 'package:fios/screens/managers/managers_list_screen.dart';
import 'package:flutter/material.dart';

class ManagersScreen extends StatefulWidget {
  static final routeName = 'managers';

  @override
  _ManagersScreenState createState() => _ManagersScreenState();
}

class _ManagersScreenState extends State<ManagersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).accentColor.withOpacity(0.6),
                      Theme.of(context).accentColor.withOpacity(0.7),
                      Theme.of(context).accentColor.withOpacity(0.8),
                    ],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                  )),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  makeRoundedButton(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ManagersListScreen('manager'),
                            ));
                      },
                      child: Text(
                        'See Managers',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )),
                  SizedBox(
                    height: 30.0,
                  ),
                  makeRoundedButton(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ManagersListScreen('referee'),
                            ));
                      },
                      child: Text(
                        'See Referees',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      )),
                ],
              )),
        ),
      ),
    );
  }

  Widget makeRoundedButton({@required Widget child, @required Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 60.0,
        child: Center(
            child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          child: child,
        )),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2.0,
                  offset: Offset(2.0, 3.0))
            ]),
      ),
    );
  }
}
