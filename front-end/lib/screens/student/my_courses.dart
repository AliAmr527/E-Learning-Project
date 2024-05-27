import 'package:ecom_ass/server/api_handler.dart';
import 'package:ecom_ass/server/models/my_course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen(
      {super.key, required this.studentId, required this.studentName});
  final String studentId;
  final String studentName;

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  List<MyCourseModel> myCourses = [];
  var currRating = 3.0;
  var reviewController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getMycourses();
  }

  Future<void> getMycourses() async {
    myCourses =
        await ApiHandler.getMyCourses(widget.studentId, widget.studentName);
    setState(() {});
  }

  Future<void> cancelCourse(var index) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
              onPressed: () async {
                var response = await ApiHandler.cancelCourse(
                  myCourses[index].id,
                  widget.studentName,
                  widget.studentId,
                );
                if (response.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Course cancelled successfully!'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(response.body)),
                  );
                }
                getMycourses();
                Navigator.pop(context);
              },
              child: const Text('Yes')),
          TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text('No'))
        ],
        title: const Text('Cancel course'),
        contentPadding: const EdgeInsets.all(15.0),
        content: const Text('Are you sure you want to cancel this course?'),
      ),
    );
  }

  Future<void> reviewCourse(var index) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
              onPressed: () async {
                var response = await ApiHandler.reviewCourse(
                  myCourses[index].id,
                  widget.studentName,
                  widget.studentId,
                  reviewController.text,
                  currRating,
                );
                if (response.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Review submitted successfully!'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(response.body)),
                  );
                }
                Navigator.pop(context);
              },
              child: const Text('Submit')),
          TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text('Cancel'))
        ],
        title: const Text('Review Course'),
        contentPadding: const EdgeInsets.all(15.0),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Column(
            children: [
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  currRating = rating;
                },
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: const InputDecoration(
                    hintText: 'Write Your Review',
                    border: OutlineInputBorder()),
                minLines: 5,
                maxLines: 10,
                controller: reviewController,
              ),
            ],
          ),
        ),
      ),
    );
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
                        "My myCourses",
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
                            width: 220,
                            child: Center(
                              child: Text('Category',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            )),
                        SizedBox(
                            width: 55,
                            child: Center(
                              child: Text('Rating',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            )),
                        SizedBox(
                            width: 100,
                            child: Center(
                              child: Text('Status',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            )),
                        SizedBox(
                            width: 120,
                            child: Center(
                              child: Text('',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            )),
                      ]),
                  Visibility(
                    visible: myCourses.isNotEmpty,
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: myCourses.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                        myCourses[index].name,
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
                                        myCourses[index].duration.toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 220,
                                    child: Center(
                                      child: Text(
                                        myCourses[index].category,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 55,
                                    child: Center(
                                      child: Text(
                                        myCourses[index].rating.toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Center(
                                      child: Text(
                                        myCourses[index].status,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120,
                                    child: Center(
                                      child: Column(children: [
                                        Visibility(
                                          visible: myCourses[index].status ==
                                              'current',
                                          child: TextButton(
                                            onPressed: () {
                                              cancelCourse(index);
                                            },
                                            child: const Text(
                                              'Cancel course',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible:
                                              myCourses[index].status == 'done',
                                          child: TextButton(
                                              onPressed: () {
                                                reviewCourse(index);
                                              },
                                              child: const Text(
                                                'Review course',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Visibility(
                      visible: myCourses.isEmpty,
                      child: const Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('You have not enrolled any courses yet'),
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
