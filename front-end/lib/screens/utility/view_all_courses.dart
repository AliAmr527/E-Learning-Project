import 'package:ecom_ass/screens/utility/view_course_detail.dart';
import 'package:ecom_ass/server/api_handler.dart';
import 'package:ecom_ass/server/models/course.dart';
import 'package:flutter/material.dart';

class ViewAllCourses extends StatefulWidget {
  const ViewAllCourses(
      {super.key,
      required this.userId,
      required this.role,
      required this.userName});
  final String userId;
  final String userName;
  final String role;

  @override
  State<ViewAllCourses> createState() => ViewAllCoursesState();
}

class ViewAllCoursesState extends State<ViewAllCourses> {
  List<CourseModel> courses = [];
  @override
  void initState() {
    super.initState();
    getAllCourses();
  }

  Future<void> getAllCourses() async {
    courses = await ApiHandler.getAllCoursesApi();
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                        "View all courses",
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
                  Expanded(
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
                                    userId: widget.userId,
                                    role: widget.role,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
