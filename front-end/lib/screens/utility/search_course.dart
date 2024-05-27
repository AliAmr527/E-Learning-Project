import 'package:ecom_ass/screens/utility/view_course_detail.dart';
import 'package:ecom_ass/server/api_handler.dart';
import 'package:ecom_ass/server/models/course.dart';
import 'package:flutter/material.dart';

class SearchCourseScreen extends StatefulWidget {
  const SearchCourseScreen(
      {super.key,
      required this.userId,
      required this.userName,
      required this.role});
  final String userId;
  final String userName;
  final String role;

  @override
  State<SearchCourseScreen> createState() => _SearchCourseScreenState();
}

const List<String> searchType = <String>['name', 'category'];
const List<String> sortType = <String>['name', 'rating'];

class _SearchCourseScreenState extends State<SearchCourseScreen> {
  String searchTypeController = searchType.first;
  String sortTypeController = searchType.first;
  List<CourseModel> courses = [];
  TextEditingController searchController = TextEditingController();

  void searchCourse() async {
    if (searchController.text.isNotEmpty) {
      courses = await ApiHandler.searchCourse(
          searchController.text, searchTypeController, sortTypeController);
      setState(() {});
    }
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
                        "Search for courses",
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
                    children: [
                      const Text('Search: '),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text('Search by: '),
                      DropdownButton(
                        value: searchTypeController,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        elevation: 3,
                        onChanged: (String? value) {
                          setState(() {
                            searchTypeController = value!;
                          });
                        },
                        items: searchType
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(width: 10),
                      const Text('Sort by: '),
                      DropdownButton(
                        value: sortTypeController,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        elevation: 3,
                        onChanged: (String? value) {
                          setState(() {
                            sortTypeController = value!;
                          });
                        },
                        items: sortType
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: searchCourse,
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
                            width: 130,
                            child: Center(
                              child: Text('Name',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            )),
                        SizedBox(
                            width: 70,
                            child: Center(
                              child: Text('Duration',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            )),
                        SizedBox(
                            width: 230,
                            child: Center(
                              child: Text('Category',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            )),
                        SizedBox(
                            width: 60,
                            child: Center(
                              child: Text('Rating',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            )),
                      ]),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: courses.isNotEmpty,
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewCourseDetail(
                                      course: courses[index],
                                      role: widget.role,
                                      userId: widget.userId,
                                      userName: widget.userName,
                                    ),
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
                                      width: 130,
                                      child: Center(
                                        child: Text(
                                          courses[index].name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 70,
                                      child: Center(
                                        child: Text(
                                          courses[index].duration.toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 230,
                                      child: Center(
                                        child: Text(
                                          courses[index].category,
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: Center(
                                        child: Text(
                                          courses[index].rating.toString(),
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
                      visible: courses.isEmpty,
                      child: const Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('No courses found'),
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
