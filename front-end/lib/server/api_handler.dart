import 'dart:convert';
import 'dart:io';

import 'package:ecom_ass/server/models/admin_course.dart';
import 'package:ecom_ass/server/models/course.dart';
import 'package:ecom_ass/server/models/my_course.dart';
import 'package:ecom_ass/server/models/notification.dart';
import 'package:ecom_ass/server/models/request.dart';
import 'package:ecom_ass/server/models/sign_in.dart';
import 'package:ecom_ass/server/models/stats.dart';
import 'package:ecom_ass/server/models/user.dart';
import 'package:http/http.dart' as http;

abstract class ApiHandler {
  //User APIs
  static const userBaseUrl = "localhost:5001";

  static const signUpUrl = "auth/register";
  static const signInUrl = "auth/login";
  //Course APIs
  static const coursesBaseUrl = "localhost:5002";

  static const createCourseUrl = "courses/create";
  static const getCoursesUrl = "courses/getAllCourses";
  static const getRequestsUrl = "courses/coursesForInstructor";
  static const approveRequestUrl = "courses/accept";
  static const rejectRequestUrl = "courses/reject";
  static const applyForCourseUrl = "courses/apply";
  static const cancelCourseUrl = "courses/cancel";
  static const getMyCoursesUrl = "courses/viewCurrentAndPast";
  static const reviewCourseUrl = "courses/review";

  static const getUnreadUrl = "courses/getAllUnreadNotifications";
  static const getAllNotificationsUrl = "courses/getAllNotifications";
  static const markAllAsReadUrl = "courses/markAllAsRead";
  //Admin APIs
  static const adminBaseUrl = "localhost:8080";

  static const getStudentsUrl = "demo_war/api/stateful/getStudents";
  static const getInstructorsUrl = "demo_war/api/stateful/getInstructors";
  static const getAllAdminCoursesUrl = "demo_war/api/stateful/getCourses";

  static const updateStudentUrl = "demo_war/api/stateful/editStudent";
  static const updateInstructorUrl = "demo_war/api/stateful/editInstructor";
  static const updateCourseUrl = "demo_war/api/stateful/editCourse";

  static const approveCourseUrl = "demo_war/api/stateful/validateCourse";
  static const removeCourseUrl = "demo_war/api/stateful/removeCourse";

  static const statsUrl = "demo_war/api/stateless/track";

  static Future<http.Response> signUpApi(
    var name,
    var email,
    var password,
    var bio,
    var affiliation,
    var role,
    var yearsOfExperience,
  ) async {
    var url = Uri.http(userBaseUrl, signUpUrl);
    if (role == "Student") {
      yearsOfExperience = null;
    }
    var response = await http.post(url,
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
          'bio': bio,
          'affiliation': affiliation,
          'role': role,
          'yearsOfExperience': yearsOfExperience
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    return response;
  }

  static Future<SignInModel?> signInApi(var email, var password) async {
    var url = Uri.http(userBaseUrl, signInUrl);
    var response = await http.post(url,
        body: json.encode({
          'email': email,
          'password': password,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    if (response.statusCode == 200) {
      return SignInModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  static Future<http.Response> createCourseApi(
    var name,
    var duration,
    var category,
    var cap,
    var createdBy,
  ) async {
    var url = Uri.http(coursesBaseUrl, createCourseUrl);
    var response = await http.post(url,
        body: json.encode({
          'name': name,
          'duration': duration,
          'category': category,
          'capacity': cap,
          'createdBy': createdBy,
          'role': 'instructor'
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    return response;
  }

  static Future<List<CourseModel>> getAllCoursesApi() async {
    var url = Uri.http(coursesBaseUrl, getCoursesUrl);
    var response = await http.get(url);
    var courseObjsJson = jsonDecode(response.body)['courses'] as List;
    List<CourseModel> courses = courseObjsJson
        .map((reviewJson) => CourseModel.fromJson(reviewJson))
        .toList();
    return courses;
  }

  static Future<List<CourseModel>> searchCourse(
    var keyword,
    var searchkey,
    var sortKey,
  ) async {
    final queryParameters = {
      searchkey.toString(): keyword,
      'sort': sortKey,
    };
    var url = Uri.http(coursesBaseUrl, getCoursesUrl, queryParameters);
    var response = await http.get(url);
    var courseObjsJson = jsonDecode(response.body)['courses'] as List;
    List<CourseModel> courses = courseObjsJson
        .map((reviewJson) => CourseModel.fromJson(reviewJson))
        .toList();
    return courses;
  }

  static Future<List<RequestModel>> getRequests(var instructorId) async {
    var url = Uri.http(coursesBaseUrl, getRequestsUrl);
    var response = await http.post(url,
        body: json.encode({'id': instructorId, 'role': 'instructor'}),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });

    var requestObjsJson = jsonDecode(response.body)['requests'] as List;
    List<RequestModel> requests = requestObjsJson
        .map((studentJson) => RequestModel.fromJson(studentJson))
        .toList();

    return requests;
  }

  static Future<http.Response> approveRequest(
    var instructorId,
    var courseId,
    var name,
    var studentId,
  ) async {
    var url = Uri.http(coursesBaseUrl, approveRequestUrl);
    var response = await http.post(url,
        body: json.encode({
          'instructorId': instructorId,
          'courseId': courseId,
          'studentId': studentId,
          'name': name
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    return response;
  }

  static Future<http.Response> denyRequest(
    var instructorId,
    var courseId,
    var name,
    var studentId,
  ) async {
    var url = Uri.http(coursesBaseUrl, rejectRequestUrl);
    var response = await http.post(url,
        body: json.encode({
          'instructorId': instructorId,
          'courseId': courseId,
          'studentId': studentId,
          'name': name
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    return response;
  }

  static Future<http.Response> applyForCourse(
    var courseId,
    var name,
    var studentId,
  ) async {
    var url = Uri.http(coursesBaseUrl, applyForCourseUrl);
    var response = await http.post(url,
        body: json.encode({
          'courseId': courseId,
          'studentId': studentId,
          'name': name,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    return response;
  }

  static Future<List<MyCourseModel>> getMyCourses(
    var studentId,
    var name,
  ) async {
    var url = Uri.http(coursesBaseUrl, getMyCoursesUrl);
    var response = await http.post(url,
        body: json.encode({
          'id': studentId,
          'name': name,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    var myCourseObjsJson = jsonDecode(response.body)['courses'] as List;
    List<MyCourseModel> courses = myCourseObjsJson
        .map((reviewJson) => MyCourseModel.fromJson(reviewJson))
        .toList();
    return courses;
  }

  static Future<http.Response> cancelCourse(
    var courseId,
    var name,
    var studentId,
  ) async {
    var url = Uri.http(coursesBaseUrl, cancelCourseUrl);
    var response = await http.post(url,
        body: json.encode({
          'courseId': courseId,
          'studentId': studentId,
          'name': name,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    return response;
  }

  static Future<http.Response> reviewCourse(
    var courseId,
    var studentName,
    var studentId,
    var review,
    var rating,
  ) async {
    var url = Uri.http(coursesBaseUrl, reviewCourseUrl);
    var response = await http.post(url,
        body: json.encode({
          'courseId': courseId,
          'studentId': studentId,
          'studentName': studentName,
          'review': review,
          'rating': rating
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    return response;
  }

  static Future<bool> getUnread(
    var studentId,
  ) async {
    var url = Uri.http(coursesBaseUrl, getUnreadUrl);
    var response = await http.post(url,
        body: json.encode({
          'id': studentId,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    return response.body == "true";
  }

  static Future<http.Response> markAllAsRead(
    var studentId,
  ) async {
    var url = Uri.http(coursesBaseUrl, markAllAsReadUrl);
    var response = await http.post(url,
        body: json.encode({
          'id': studentId,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    return response;
  }

  static Future<List<NotificationModel>> getAllNotifications(
      var studentId) async {
    var url = Uri.http(coursesBaseUrl, getAllNotificationsUrl);
    var response = await http.post(url,
        body: json.encode({
          'id': studentId,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    var notificationObjsJson =
        jsonDecode(response.body)['notifications'] as List;
    List<NotificationModel> notifications = notificationObjsJson
        .map((reviewJson) => NotificationModel.fromJson(reviewJson))
        .toList();
    return notifications;
  }

  static Future<List<UserModel>> getUserDetails(var searchType) async {
    Uri url;
    if (searchType == "instructor") {
      url = Uri.http(adminBaseUrl, getInstructorsUrl);
    } else {
      url = Uri.http(adminBaseUrl, getStudentsUrl);
    }
    var response = await http.get(url);
    List<dynamic> usersObjsJson;
    if (searchType == "instructor") {
      usersObjsJson = jsonDecode(response.body)['instructors'] as List;
    } else {
      usersObjsJson = jsonDecode(response.body)['students'] as List;
    }

    List<UserModel> users = usersObjsJson
        .map((reviewJson) => UserModel.fromJson(reviewJson))
        .toList();
    return users;
  }

  static Future<http.Response> updateUserDetails(
    var userId,
    var name,
    var email,
    var password,
    var bio,
    var affiliation,
    var role,
    var yearsOfExperience,
  ) async {
    var subURL = "";
    if (role == "student") {
      subURL = updateStudentUrl;
    } else if (role == "instructor") {
      subURL = updateInstructorUrl;
    }
    var url = Uri.http(adminBaseUrl, '$subURL/$userId');
    var response = await http.post(url,
        body: json.encode({
          if (name.isNotEmpty) 'name': name,
          if (email.isNotEmpty) 'email': email,
          if (password.isNotEmpty) 'password': password,
          if (bio.isNotEmpty) 'bio': bio,
          if (affiliation.isNotEmpty) 'affiliation': affiliation,
          if (role.isNotEmpty) 'role': role,
          if (yearsOfExperience.isNotEmpty)
            'yearsOfExperience': yearsOfExperience
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    return response;
  }

  static Future<List<AdminCourseModel>> getAdminCourses() async {
    var url = Uri.http(adminBaseUrl, getAllAdminCoursesUrl);
    var response = await http.get(url);
    var adminCourseObjsJson = jsonDecode(response.body)['courses'] as List;
    List<AdminCourseModel> courses = adminCourseObjsJson
        .map((reviewJson) => AdminCourseModel.fromJson(reviewJson))
        .toList();
    return courses;
  }

  static Future<http.Response> publishCourse(
    var courseId,
  ) async {
    var url = Uri.http(adminBaseUrl, '$approveCourseUrl/$courseId');
    var response = await http.post(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return response;
  }

  static Future<http.Response> removeCourse(
    var courseId,
  ) async {
    var url = Uri.http(adminBaseUrl, '$removeCourseUrl/$courseId');
    var response = await http.post(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return response;
  }

  static Future<http.Response> updateCourseDetails(
    var courseId,
    var name,
    var duration,
    var category,
    var capacity,
  ) async {
    var url = Uri.http(adminBaseUrl, '$updateCourseUrl/$courseId');
    var response = await http.post(url,
        body: json.encode({
          if (name.isNotEmpty) 'name': name,
          if (duration.isNotEmpty) 'duration': duration,
          if (category.isNotEmpty) 'category': category,
          if (capacity.isNotEmpty) 'capacity': capacity,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    return response;
  }

  static Future<StatsModel> getStats() async {
    var url = Uri.http(adminBaseUrl, statsUrl);
    var response = await http.get(url);
    StatsModel stats = StatsModel.fromJson(jsonDecode(response.body)['stats']);

    return stats;
  }
}
