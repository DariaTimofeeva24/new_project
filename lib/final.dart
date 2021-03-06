import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'networking.dart';

Future<List<User>> _fetchUsersList() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body) as List <dynamic>;
    return jsonResponse.map((dynamic e) => User.fromJson(e as Map<String, dynamic>)).toList();
  } else {
    throw Exception('Failed to load users from API');
  }
}

ListView _usersListView(data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _userListTile(data[index].name, data[index].email, Icons.work);
      });
}

ListTile _userListTile(String title, String subtitle, IconData icon) => ListTile(
  title: Text(title,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
      )),
  subtitle: Text(subtitle),
  leading: Icon(
    icon,
    color: Colors.blue[500],
  ),
);

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  late Future<List<User>> futureUsersList;
  late List<User> usersListData;

  @override
  void initState() {
    super.initState();
    futureUsersList = _fetchUsersList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<List<User>>(
            future: futureUsersList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                usersListData = snapshot.data!;
                return _usersListView(usersListData);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            })
    );
  }
}
