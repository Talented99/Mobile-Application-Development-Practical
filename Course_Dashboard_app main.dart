import 'package:flutter/material.dart';

void main() {
  runApp(CourseDashboardApp());
}

class CourseDashboardApp extends StatelessWidget {
  const CourseDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Course Dashboard",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

// ---------------- MAIN SCREEN WITH BOTTOM NAV ----------------
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [HomeScreen(), CoursesScreen(), ProfileScreen()];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Course Dashboard")),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Courses"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// ---------------- a. COURSE LIST VIEW ----------------
class CoursesScreen extends StatelessWidget {
  final List<Map<String, String>> courses = [
    {"name": "Information Project Management", "instructor": "Dr. K .Adu"},
    {"name": "Research Method", "instructor": "Prof. Appaiahene"},
    {"name": "Python", "instructor": "Mr. M.J.Ayitey"},
    {
      "name": "Advance Web Engineering and Application with PHP",
      "instructor": "P.M Sarfo",
    },
    {"name": "Mobile Application", "instructor": "Mr.Emmanuel Botchway"},
  ];

  CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.book),
          title: Text(courses[index]["name"]!),
          subtitle: Text("Instructor: ${courses[index]["instructor"]}"),
        );
      },
    );
  }
}

// ---------------- b. HOME SCREEN (ACTIVE TAB + ANIMATED BUTTON) ----------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _scale = 1.0;
  String selectedCategory = "None";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Active Tab: Home",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),

          // d. Animated Action Button
          GestureDetector(
            onTapDown: (_) {
              setState(() {
                _scale = 1.2;
              });
            },
            onTapUp: (_) {
              setState(() {
                _scale = 1.0;
              });
            },
            child: AnimatedScale(
              scale: _scale,
              duration: Duration(milliseconds: 200),
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Enroll in a Course"),
              ),
            ),
          ),

          SizedBox(height: 40),

          // e. Course Selection Dropdown
          DropdownButton<String>(
            value: selectedCategory == "None" ? null : selectedCategory,
            hint: Text("Select Course Category"),
            items: ["Python", "Mobile Application", "Research Method"].map((
              String category,
            ) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCategory = value!;
              });
            },
          ),
          SizedBox(height: 10),
          Text("Selected Category: $selectedCategory"),
        ],
      ),
    );
  }
}

// ---------------- c. PROFILE SCREEN (LOGOUT + DIALOG) ----------------
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to exit the app?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Close dialog
            },
            child: Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Close dialog
              Navigator.of(context).maybePop(); // Simulate exit
            },
            child: Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => _showLogoutDialog(context),
        child: Text("Logout"),
      ),
    );
  }
}

