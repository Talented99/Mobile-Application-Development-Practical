import 'package:flutter/material.dart';

void main() {
  runApp(StudentInfoApp());
}

class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Info Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    WelcomeDashboard(),
    InteractiveNotification(),
    StudentCounter(),
    StudentLoginForm(),
    ProfilePictureDisplay(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Info Manager")),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notification",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Counter"),
          BottomNavigationBarItem(icon: Icon(Icons.login), label: "Login"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// ---------------- a. WELCOME DASHBOARD ----------------
class WelcomeDashboard extends StatelessWidget {
  const WelcomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Name: Israel Nanatuffour\nCourse: Information Technolgy\nUniversity: UENR",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
          ),
        ),
      ),
    );
  }
}

// ---------------- b. INTERACTIVE NOTIFICATION ----------------
class InteractiveNotification extends StatelessWidget {
  const InteractiveNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Hello, Israel! Welcome to the Student Info Manager.",
              ),
            ),
          );
        },
        child: Text("Show Alert"),
      ),
    );
  }
}

// ---------------- c. STUDENT COUNTER ----------------
class StudentCounter extends StatefulWidget {
  const StudentCounter({super.key});

  @override
  State<StudentCounter> createState() => _StudentCounterState();
}

class _StudentCounterState extends State<StudentCounter> {
  int studentCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Students Enrolled: $studentCount",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove, color: Colors.red),
              onPressed: () {
                setState(() {
                  if (studentCount > 0) studentCount--;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.add, color: Colors.green),
              onPressed: () {
                setState(() {
                  studentCount++;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------- d. STUDENT LOGIN FORM ----------------
class StudentLoginForm extends StatefulWidget {
  const StudentLoginForm({super.key});

  @override
  State<StudentLoginForm> createState() => _StudentLoginFormState();
}

class _StudentLoginFormState extends State<StudentLoginForm> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Email"),
              onChanged: (val) => email = val,
              validator: (val) {
                if (val == null || !val.contains("@")) {
                  return "Enter a valid email";
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
              onChanged: (val) => password = val,
              validator: (val) {
                if (val == null || val.length < 6) {
                  return "Password must be at least 6 characters";
                }
                return null;
              },
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Login Successful")));
                }
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- e. PROFILE PICTURE DISPLAY ----------------
class ProfilePictureDisplay extends StatelessWidget {
  const ProfilePictureDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: Image.network(
          "https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg",
          height: 150,
          width: 150,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
