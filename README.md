
# E-Learning Platform
A simple web application simulating a fully working E-Learning site having 3 roles; admin, instructor and student. 
## This project includes various functionalities such as:
### Instructor being able to: 
- Create courses and manage them 
- Accept student enrollments
### Admin being able to: 
- Track the application stats 
- Accept courses  
- Alter any user's info
### Students being able to: 
- Apply for courses
- Cancel their application 
- Review courses
## Application structure 
<ul>
<li>Flutter as a frontend framework</li>
</ul>
&ensp;&ensp;&ensp; And having 3 microservices as our backend developed using:
<ul>
<li>Java EJBs and tomcat as a hosting server </li>
<li>Nodejs</li>
</ul>
&ensp;&ensp;&ensp; As for our database we used: 
<ul>
<li>Mongo Atlas</li>
</ul>

## Screenshots
Sign-in page                | 
:-------------------------: |
![1](https://github.com/AliAmr527/simple-DS-ecomm/assets/131396543/6892686c-3728-4e66-b08e-817a51375d10) 
Track Stats                |
![2](https://github.com/AliAmr527/simple-DS-ecomm/assets/131396543/33d95ad0-a23d-4f3f-9268-6dc4bd8c08b3)
Admin View / Delete Course         |
![3](https://github.com/AliAmr527/simple-DS-ecomm/assets/131396543/41a24e5e-31a0-43b9-9405-5a37fa73f7ee)
Viewing Course            |
![4](https://github.com/AliAmr527/simple-DS-ecomm/assets/131396543/150ddd2e-ebf4-48af-88b5-d1f3112014bf)
Searching Courses           |
![5](https://github.com/AliAmr527/simple-DS-ecomm/assets/131396543/a0e20dd6-5bbb-4859-b72f-c681004019f2)
Notifications               |
![6](https://github.com/AliAmr527/simple-DS-ecomm/assets/131396543/3931377a-1211-40ba-a8b4-7e302456f864)
Student Home Page           |
![7](https://github.com/AliAmr527/simple-DS-ecomm/assets/131396543/267b936e-6ae0-4306-ac8a-eb87196424ee)




## Environment Variables

To run this project, you will need to add the following environment variables to your .env file in each folder for each microservice

## Courses Microservice

`COURSES_DB_NAME`

## Users Microservice

`USERS_DB_NAME`


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

