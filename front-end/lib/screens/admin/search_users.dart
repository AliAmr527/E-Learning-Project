import 'package:ecom_ass/screens/admin/view_user_detail.dart';
import 'package:ecom_ass/server/api_handler.dart';
import 'package:ecom_ass/server/models/user.dart';
import 'package:flutter/material.dart';

class SearchUsersScreen extends StatefulWidget {
  const SearchUsersScreen({super.key});

  @override
  State<SearchUsersScreen> createState() => _SearchUsersState();
}

const List<String> userViewType = <String>['student', 'instructor'];

class _SearchUsersState extends State<SearchUsersScreen> {
  String userViewTypeController = userViewType.first;
  List<UserModel> users = [];

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() async {
    users = await ApiHandler.getUserDetails(userViewTypeController);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.arrow_back_rounded),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      const Text(
                        "Search for users",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40, width: 40),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('View: '),
                      DropdownButton(
                        value: userViewTypeController,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        elevation: 3,
                        onChanged: (String? value) {
                          setState(() {
                            userViewTypeController = value!;
                          });
                        },
                        items: userViewType
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: getUsers,
                        child: const Text('Search'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            width: 150,
                            child: Center(
                              child: Text('Name',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            )),
                        SizedBox(
                            width: 200,
                            child: Center(
                              child: Text('Affiliation',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            )),
                        SizedBox(
                            width: 250,
                            child: Center(
                              child: Text('Bio',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            )),
                      ]),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: users.isNotEmpty,
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewUserDetailScreen(
                                        user: users[index]),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: Center(
                                        child: Text(
                                          users[index].name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Center(
                                        child: Text(
                                          users[index].affiliation.toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 250,
                                      child: Center(
                                        child: Text(
                                          users[index].bio,
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Visibility(
                      visible: users.isEmpty,
                      child: const Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('No users found'),
                        ],
                      ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
