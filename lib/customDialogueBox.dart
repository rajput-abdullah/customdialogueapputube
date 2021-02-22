import 'dart:convert';
import 'dart:ui';
import 'package:customdialogueapputube/User.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDialogueBox extends StatefulWidget {
  @override
  _CustomDialogueBoxState createState() => _CustomDialogueBoxState();
}

class _CustomDialogueBoxState extends State<CustomDialogueBox> {
  bool canUpload = false;


  TextEditingController _editingController = TextEditingController();
  showConfirmationDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CustomDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Custom Dialogue',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 80),
        color: Colors.grey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
                controller: _editingController,
                readOnly: true,
                onTap: () => showConfirmationDialog(context))
          ],
        ),
      ),
    );
  }
}

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  void initState() {
    super.initState();
    print('user');
    this.loadUser();
  }
  List<User> users = [];


  Future<List<User>> loadUser() async {
    String url = "http://192.168.11.153:8075/api/users";
    final response = await http.get(url);

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    for (var singleUser in responseData) {
      User user = User(
          id: singleUser["id"],
          userName: singleUser["user_name"],
          role: singleUser["role"]);

      // print(responseData);
      //   //Adding user to the list.
      users.add(user);

    }
    setState(() {
      responseData = users;
    });
    print(users);
    return users;
  }


  List<bool> _isChecked = [false, false];
  bool canUpload = false;
  List<String> _texts = [
    "I have confirm the data is correct",
    "I have agreed to terms and conditions.",
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmation'),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(8.0),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (_, index) {
                        return CheckboxListTile(
                          title: Text(users[index].userName.toString()),
                          value: _isChecked[index],
                          onChanged: (val) {
                            setState(() {
                              _isChecked[index] = val;
                              canUpload = true;
                              for (var item in _isChecked) {
                                if (item == true) {
                                  canUpload = true;
                                }
                              }
                            });
                          },
                        );
                      },
                    ),
                  ]),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        SizedBox(
            width: 300,
            child: RaisedButton(
              color: Colors.blue,
              onPressed: canUpload
                  ? () {
              Navigator.pop(context);
              }
                  : null,
              child: Text('Upload'),
            ))
      ],
    );
  }

}