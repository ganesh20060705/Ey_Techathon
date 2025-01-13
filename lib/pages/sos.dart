import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SOSPage extends StatefulWidget {
  const SOSPage({Key? key}) : super(key: key);

  @override
  _SOSPageState createState() => _SOSPageState();
}

class _SOSPageState extends State<SOSPage> {
  final String apiUrl = 'http://10.0.2.2:5000/api/medical-card'; // Adjust the port as needed
  Map<String, dynamic>? medicalCard;
  int clickCount = 0; // Track the number of clicks

  @override
  void initState() {
    super.initState();
    fetchMedicalCard();
  }

  Future<void> fetchMedicalCard() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          medicalCard = json.decode(response.body);
        });
      } else {
        print('Failed to fetch medical card: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching medical card: $e');
    }
  }

  Future<void> handleSOSClick() async {
    setState(() {
      clickCount++;
    });

    if (clickCount == 1) {
      print("Sending SOS alert to Ravi...");
      await sendAlertToRavi();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("SOS Alert Sent to Ravi"),
            content: const Text("Your emergency alert has been sent to Ravi."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } else if (clickCount == 2) {
      print("Sending SOS notification to the given number...");
      await notifyGivenNumber();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("SOS Notification Sent"),
            content: const Text("Your emergency notification has been sent to the given number."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } else if (clickCount == 3) {
      print("Sending SOS notification to Ambulance...");
      await notifyAmbulance();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("SOS Notification Sent to Ambulance"),
            content: const Text("Your emergency notification has been sent to the ambulance."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );

      setState(() {
        clickCount = 0; // Reset after the third click
      });
    }
  }

  Future<void> sendAlertToRavi() async {
    // Implement your API call to notify Ravi here
  }

  Future<void> notifyGivenNumber() async {
    // Implement your API call to notify the given number here
  }

  Future<void> notifyAmbulance() async {
    // Implement your API call to notify the ambulance here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency SOS"),
        backgroundColor: Color(0xFFAED6F1),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFAED6F1),
              ),
              child: const Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("Profile"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Text(
                    "Notice:\n"
                    "1st Click: Sends an SOS alert to Ravi.\n"
                    "2nd Click: Notifies the given emergency contact number.\n"
                    "3rd Click: Notifies and dispatches an ambulance.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Click the button below for emergency assistance.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: handleSOSClick,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE57373), Color(0xFFD32F2F)], // Changed colors
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "SOS",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                medicalCard != null
                    ? Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Medical Card",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Card Number: ${medicalCard?['card_number'] ?? 'N/A'}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Name: ${medicalCard?['name'] ?? 'N/A'}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Age: ${medicalCard?['age'] ?? 'N/A'}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Symptoms: ${medicalCard?['symptoms']?.join(', ') ?? 'N/A'}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                print("View Medical Records");
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFAED6F1),
                              ),
                              child: const Text("View Full Records"),
                            ),
                          ],
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
