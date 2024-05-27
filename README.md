
# E-Learning Platform

Simple Fullstack E-COMM Web Application 

# Project Summary

A simple web application simulating a fully working E-Learning site having 3 roles; admin, instructor and student. 
## This project includes various functionalities such as:
Instructor being able to: 
- Create courses and manage them 
- Accept student enrollments. 
Admin being able to: 
- Track the application stats 
- Accept courses  
- Alter any user's info. 
Students being able to: 
- Apply for courses
- Cancel their application 
- Review those courses when they have finished them.
## Application structure 
- Flutter as a frontend framework
And having 3 microservices as our backend developed using:
- Java EJBs and tomcat as a hosting server 
- Nodejs
as for our database we used: 
- Mongo Atlas

## Screenshots
Sign-in page                | Track Status                |
:-------------------------: | :-------------------------: |
![1](https://github.com/AliAmr527/simple-DS-ecomm/assets/131396543/6892686c-3728-4e66-b08e-817a51375d10) | ![2](https://github.com/AliAmr527/simple-DS-ecomm/assets/131396543/33d95ad0-a23d-4f3f-9268-6dc4bd8c08b3)




## Environment Variables

To run this project, you will need to add the following environment variables to your .env file in each folder for each microservice

## Courses Microservice

`COURSES_DB_NAME`

## Users Microservice

`ANOTHER_API_KEY`


## Deployment

To run this project you must install the following:
- intellij
- Flutter SDK
- Dart SDK
- TomCat Server
- Java
- NodeJs

To run the project:

```bash
  cd ./users
  npm i
```

```bash
  cd ./courses
  npm i
```

```bash
  node server.js
```

```bash
  start server in intellij
```

```bash
  cd ./front-end
  flutter run
```

