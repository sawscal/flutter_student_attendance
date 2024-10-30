import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AttendancePage(),
    );
  }
}

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  String? selectedClass;
  String? selectedSection;

  List<String> classes = ['Class 1', 'Class 2', 'Class 3'];
  List<String> sections = ['Section A', 'Section B', 'Section C'];

  Map<String, List<Map<String, dynamic>>> students = {
    'Class 1-Section A': [
      {'name': 'John Doe', 'isPresent': false, 'entryTime': '9:00 AM'},
      {'name': 'Jane Smith', 'isPresent': true, 'entryTime': '9:05 AM'},
    ],
    'Class 1-Section B': [
      {'name': 'Alice Brown', 'isPresent': false, 'entryTime': '9:10 AM'},
      {'name': 'Bob White', 'isPresent': true, 'entryTime': '9:15 AM'},
    ],
    'Class 1-Section C': [
      {'name': 'Trevin Both', 'isPresent': false, 'entryTime': '9:00AM'},
      {'name': 'Celvin Tras', 'isPresent': true, 'entryTime': '9: 12 AM'},
    ],
    'Class 2-Section A': [
      {'name': 'Mctrauf', 'isPresent': false, 'entryTime': '9:00 AM'},
      {'name': 'Drake Blink', 'isPresent': true, 'entryTime': '9:05 AM'},
    ],
    'Class 2-Section B': [
      {'name': 'Blue Puppy', 'isPresent': false, 'entryTime': '9:10 AM'},
      {'name': 'Little White', 'isPresent': true, 'entryTime': '9:15 AM'},
    ],
    'Class 2-Section C': [
      {'name': 'Struat Little', 'isPresent': false, 'entryTime': '9:00AM'},
      {'name': 'Ben Miles', 'isPresent': true, 'entryTime': '9: 12 AM'},
    ],
    'Class 3-Section A': [
      {'name': 'Andrew Fine', 'isPresent': false, 'entryTime': '9:00 AM'},
      {'name': 'oK Smith', 'isPresent': true, 'entryTime': '9:05 AM'},
    ],
    'Class 3-Section B': [
      {'name': 'Black White', 'isPresent': false, 'entryTime': '9:10 AM'},
      {'name': 'Bob White', 'isPresent': true, 'entryTime': '9:15 AM'},
    ],
    'Class 3-Section C': [
      {'name': 'Alice Both', 'isPresent': false, 'entryTime': '9:00AM'},
      {'name': 'Celvin Tras', 'isPresent': true, 'entryTime': '9: 12 AM'},
    ],
  };

  String getSelectedKey() {
    return "${selectedClass ?? ''}-${selectedSection ?? ''}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Student Attendance',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: Colors.black,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 240),
                      Lottie.network(
                        'https://lottie.host/ac1ba678-0208-4cea-8ee0-b1a2f14aa6c0/QrWskiOzHl.json',
                        width: 300,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          DropdownButtonFormField<String>(
                            value: selectedClass,
                            decoration: InputDecoration(
                              labelText: 'Select Class',
                              labelStyle: GoogleFonts.poppins(
                                  color: Colors.black87), // Label style
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Rounded corners
                                borderSide: BorderSide(
                                    color: Colors.blue), // Border color
                              ),
                              filled: true,
                              fillColor: Colors.white, // Background color
                            ),
                            isExpanded: true,
                            style: GoogleFonts.poppins(color: Colors.black),
                            items: classes.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: GoogleFonts.poppins(),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedClass = newValue;
                                selectedSection = null;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          DropdownButtonFormField<String>(
                            value: selectedSection,
                            decoration: InputDecoration(
                              labelText: 'Select Section',
                              labelStyle:
                                  GoogleFonts.poppins(color: Colors.black87),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(color: Colors.amber),
                              ),
                              filled: true,
                              fillColor: Colors.white, // Background color
                            ),
                            isExpanded: true,
                            style: GoogleFonts.poppins(color: Colors.black87),
                            items: sections.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child:
                                    Text(value, style: GoogleFonts.poppins()),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedSection = newValue;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          selectedClass != null && selectedSection != null
                              ? Expanded(
                                  child: ListView(
                                    children: students[getSelectedKey()]
                                            ?.map((student) {
                                          return InkWell(
                                            onTap: () =>
                                                _showAttendanceDialog(student),
                                            child: Container(
                                              height: 80,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5.0),
                                              child: Row(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                        child: CircleAvatar(
                                                          radius:
                                                              30, // Adjusted size
                                                          backgroundColor:
                                                              Colors.amber,
                                                          child: Text(
                                                            student['name'][0],
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 25,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Icon(
                                                          student['isPresent']
                                                              ? Icons.circle
                                                              : Icons.circle,
                                                          size: 15,
                                                          color: student[
                                                                  'isPresent']
                                                              ? Colors.green
                                                              : Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        student['name'],
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            student['isPresent']
                                                                ? 'Present'
                                                                : 'Absent',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: student[
                                                                      'isPresent']
                                                                  ? Colors.green
                                                                  : Colors.red,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Entry Time: ${student['entryTime']}',
                                                            style: GoogleFonts
                                                                .poppins(),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList() ??
                                        [const Text('No students found')],
                                  ),
                                )
                              : const SizedBox(height: 20),
                          const Text(
                              'Please select class and section to view students'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void _showAttendanceDialog(Map<String, dynamic> student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Mark Attendance for ${student['name']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Present Button with Icon
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    student['isPresent'] = true;
                  });
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.check, // Check icon for Present
                  color: Colors.green, // Green color for present
                ),
                label: const Text('Present'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.green,
                  backgroundColor: Colors.white, // Text color
                ),
              ),
              const SizedBox(height: 10), // Add some space between buttons
              // Absent Button with Icon
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    student['isPresent'] = false;
                  });
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close, // Close icon for Absent
                  color: Colors.red, // Red color for absent
                ),
                label: const Text('Absent'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.white, // Text color
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
