import 'package:ecom_ass/screens/utility/search_course.dart';
import 'package:ecom_ass/screens/utility/sign_in_screen.dart';
import 'package:ecom_ass/screens/student/my_courses.dart';
import 'package:ecom_ass/server/api_handler.dart';
import 'package:ecom_ass/server/models/notification.dart';
import 'package:flutter/material.dart';

import '../utility/view_all_courses.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen(
      {super.key, required this.studentName, required this.studentId});
  final String studentName;
  final String studentId;

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  bool unread = false;
  List<NotificationModel> notifications = [];
  @override
  void initState() {
    super.initState();
    getUnread();
    getNotifications();
  }

  Future<void> getUnread() async {
    unread = await ApiHandler.getUnread(widget.studentId);
    if (unread) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You have new notifications!'),
        ),
      );
    }
    setState(() {});
  }

  Future<void> getNotifications() async {
    notifications = await ApiHandler.getAllNotifications(widget.studentId);
    setState(() {});
  }

  Future<void> viewNotifications() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          Visibility(
            visible: unread,
            child: TextButton(
                onPressed: () async {
                  var response =
                      await ApiHandler.markAllAsRead(widget.studentId);
                  if (response.statusCode == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Marked as read!'),
                      ),
                    );
                    getUnread();
                    getNotifications();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('error: ${response.body}')),
                    );
                  }
                  Navigator.pop(context);
                },
                child: const Text('Mark all as read')),
          ),
          TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text('close'))
        ],
        title: const Text('Cancel course'),
        contentPadding: const EdgeInsets.all(15.0),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 0.3,
          child: Column(
            children: [
              Visibility(
                visible: notifications.isNotEmpty,
                child: Expanded(
                  child: ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(notifications[index].title),
                          subtitle: Text(notifications[index].message),
                          leading: CircleAvatar(
                            child: () {
                              if (notifications[index].status == 'read') {
                                return const Icon(
                                    Icons.mark_email_read_outlined);
                              } else {
                                return const Icon(
                                    Icons.mark_email_unread_outlined,
                                    color: Colors.green);
                              }
                            }(),
                          ),
                        );
                      }),
                ),
              ),
              Visibility(
                  visible: notifications.isEmpty,
                  child: const Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('No notifications!'),
                    ],
                  ))),
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
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40, width: 40),
                          const Text("Student", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          IconButton(
                              icon: const Icon(Icons.refresh_rounded),
                              onPressed: () {
                                getUnread();
                                getNotifications();
                              }),
                        ],
                      ),
                      Text(widget.studentName,
                          style: const TextStyle(fontSize: 24)),
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16.0),
                        child: Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyCoursesScreen(
                                          studentId: widget.studentId,
                                          studentName: widget.studentName,
                                        )),
                              );
                            },
                            icon: const Icon(Icons.person_rounded),
                            label: const Text('My Courses'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16.0),
                        child: Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewAllCourses(
                                    userId: widget.studentId,
                                    role: 'student',
                                    userName: widget.studentName,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.menu_rounded),
                            label: const Text('View all courses'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16.0),
                        child: Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchCourseScreen(
                                          role: 'student',
                                          userId: widget.studentId,
                                          userName: widget.studentName,
                                        )),
                              );
                            },
                            icon: const Icon(Icons.manage_search_rounded),
                            label: const Text('Search for courses'),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !unread,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16.0),
                          child: Center(
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                await viewNotifications();
                              },
                              icon:
                                  const Icon(Icons.notifications_none_rounded),
                              label: const Text('No notifications'),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: unread,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16.0),
                          child: Center(
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                await viewNotifications();
                              },
                              icon: const Icon(Icons.notifications_rounded,
                                  color: Colors.green),
                              label: const Text(
                                'New Notifications',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16.0),
                        child: Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("You have been logged out!"),
                              ));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInScreen()),
                              );
                            },
                            icon: const Icon(Icons.logout_rounded,
                                color: Colors.red),
                            label: const Text('Logout',
                                style: TextStyle(color: Colors.red)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
