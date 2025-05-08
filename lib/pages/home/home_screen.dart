// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smart_foot_traffic_ui/components/appbar_state.dart';
import 'package:smart_foot_traffic_ui/components/summary_board.dart';
import 'package:smart_foot_traffic_ui/components/calendar_dropdown.dart';
import 'package:smart_foot_traffic_ui/components/dropdown_selector.dart';
import 'package:smart_foot_traffic_ui/components/zoom_button.dart';
import '../../components/heatmap_view.dart';
import 'package:http/http.dart' as http;

class PersistentHeatmapView extends StatefulWidget {
  final String url;

  const PersistentHeatmapView({required this.url, super.key});

  @override
  State<PersistentHeatmapView> createState() => _PersistentHeatmapViewState();
}

class _PersistentHeatmapViewState extends State<PersistentHeatmapView> {
  @override
  Widget build(BuildContext context) {
    return HeatmapView(url: widget.url);
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedTrafficType;
  String? selectedDate;
  String? selectedTime;
  String? selectedSeason;
  String? heatmapUrl;
  bool isDropdownOpen = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar - When pressed, reset state
      // Void resetSatete() is down below
      appBar: CustomAppBar(onHomePressed: resetState),

      // Body - Contains the dropdowns and heatmap view
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 16),

                    // 1. Traffic Type Dropdown
                    DropdownSelector(
                      label: "Traffic Type",
                      items: const [
                        "Traffic Type",
                        "Pedestrian",
                        "Vehicle",
                        "Cyclist"
                      ],
                      selectedValue: selectedTrafficType ?? "Traffic Type",
                      onChanged: (value) {
                        setState(() {
                          selectedTrafficType =
                              value == "Traffic Type" ? null : value;
                        });
                      },
                      onDropdownStateChanged: (isOpen) {
                        setState(() {
                          isDropdownOpen = isOpen;
                        });
                      },
                    ),
                    const SizedBox(width: 16),

                    // 2. Date Picker Dropdown
                    // Call _buildDatePickerButton() function
                    _buildDatePickerButton(),
                    const SizedBox(width: 16),

                    // 3. Time Picker Dropdown
                    DropdownSelector(
                      label: "Time",
                      items: const [
                        "Time",
                        "00:00:00",
                        "01:00:00",
                        "02:00:00",
                        "03:00:00",
                        "04:00:00",
                        "05:00:00",
                        "06:00:00",
                        "07:00:00",
                        "08:00:00",
                        "09:00:00",
                        "10:00:00",
                        "11:00:00",
                        "12:00:00",
                        "13:00:00",
                        "14:00:00",
                        "15:00:00",
                        "16:00:00",
                        "17:00:00",
                        "18:00:00",
                        "19:00:00",
                        "20:00:00",
                        "21:00:00",
                        "22:00:00",
                        "23:00:00"
                      ],
                      selectedValue: selectedTime ?? "Time",
                      onChanged: (value) {
                        setState(() {
                          selectedTime = value == "Time" ? null : value;
                        });
                      },
                      onDropdownStateChanged: (isOpen) {
                        setState(() {
                          isDropdownOpen = isOpen;
                        });
                      },
                    ),
                    const SizedBox(width: 16),

                    // 4. Season Dropdown
                    DropdownSelector(
                      label: "Season",
                      items: const [
                        "Season",
                        "Summer",
                        "Autumn",
                        "Winter",
                        "Spring"
                      ],
                      selectedValue: selectedSeason ?? "Season",
                      onChanged: (value) {
                        setState(() {
                          selectedSeason = value == "Season" ? null : value;
                        });
                      },
                      onDropdownStateChanged: (isOpen) {
                        setState(() {
                          isDropdownOpen = isOpen;
                        });
                      },
                    ),
                    const SizedBox(width: 16),

                    // 5. Generate Button
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo[900],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4,
                        ),
                        onPressed: generateHeatmap,
                        child: const Text("Generate →"),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // 6. Reset Button
                    // Check zoom_button.dart for the code
                    // Only works when the heatmap is generated
                    // Open in a new tab
                    ZoomButton(url: heatmapUrl),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // 7. Heatmap View and Summary Board
            // Check heatmap_view.dart for the code
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: isDropdownOpen
                          ? Container(
                              color: Colors.white,
                              child: const Center(
                                child: Text(
                                  "Select Parameters",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ),
                            )
                          : isLoading
                              ? const Center(
                                  child:
                                      CircularProgressIndicator(), // 🌀 Show loading
                                )
                              : (heatmapUrl == null
                                  ? const Center(
                                      child: Text(
                                        "No Map",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : PersistentHeatmapView(
                                      url: heatmapUrl!,
                                      key: ValueKey(heatmapUrl),
                                    )),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 12, right: 12, bottom: 12),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: const SummaryBoard(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build the calendar dropdown button
  Widget _buildDatePickerButton() {
    return CalendarDropdown(
      onDateSelected: (pickedDate) {
        setState(() {
          selectedDate =
              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
        });
      },
      onDropdownStateChanged: (isOpen) {
        setState(() {
          isDropdownOpen = isOpen;
        });
      },
      // First and Last date for calendar (1 year of data)
      // You can change this to your needs
      firstDate: DateTime(2024, 3, 4),
      lastDate: DateTime(2025, 3, 3),
    );
  }

  // This function is called when the "Generate" button is pressed
  void generateHeatmap() async {
    // Logs for debugging
    print("\nGenerateHeatmap function called");
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    print("Traffic Type: $selectedTrafficType");
    print("Selected Date: $selectedDate");
    print("Selected Time: $selectedTime");
    print("Selected Season: $selectedSeason");
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");

    // Check if fields are filled
    if (selectedTrafficType == null || selectedDate == null) {
      print("Please select traffic type and date first!");
      return;
    }

    // Logic to convert selected traffic type to backend format
    String trafficTypeForBackend = "";
    if (selectedTrafficType == "Pedestrian") {
      trafficTypeForBackend = "Pedestrian Count";
    } else if (selectedTrafficType == "Vehicle") {
      trafficTypeForBackend = "Vehicle Count";
    } else if (selectedTrafficType == "Cyclist") {
      trafficTypeForBackend = "Cyclist Count";
    }

    // 🌐 Backend API URL – used to trigger heatmap generation via POST request
    // ===============================================
    // 🧪 OPTION 1: Use Localhost (for debugging on local machine)
    // 👉 Make sure your backend is running locally (Flask)
    // 👉 Use 127.0.0.1 for Android Emulator, or your PC IP for physical device
    // ===============================================
    // final url = Uri.parse("http://127.0.0.1:5000/api/generate_heatmap"); // Emulator
    final url =
        Uri.parse("http://192.168.1.118:5000/api/generate_heatmap"); // Local IP

    // ===============================================
    // ☁️ OPTION 2: Use Render (cloud backend)
    // 👉 Use this when testing deployed cloud version
    // ===============================================
    // final url = Uri.parse(
    //     "https://smart-foot-traffic-backend.onrender.com/api/generate_heatmap");

    // This is the payload sent to the backend
    setState(() {
      isLoading = true;
    });

    // This is the HTTP POST request to generate the heatmap
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "date": selectedDate,
          "time": selectedTime,
          "traffic_type": trafficTypeForBackend,
          "season": selectedSeason,
        }),
      );

      // Check the response from the backend
      // If the response is successful, update the heatmap URL
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          // Update the webview url to display the generated
          heatmapUrl = data['heatmap_url'];
        });
        // Log successfull
        print("Heatmap generated at: $heatmapUrl");
      } else {
        // Unsuccessful response
        print("Failed to generate heatmap. Status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error generating heatmap: $e");
    } finally {
      setState(() {
        // Stop loading
        isLoading = false;
      });
    }
  }

  // Reset everything when the home button is pressed
  // Or navigating from another screen to home
  void resetState() {
    setState(() {
      selectedTrafficType = null;
      selectedDate = null;
      selectedTime = null;
      selectedSeason = null;
      heatmapUrl = null;
      isDropdownOpen = false;
    });
  }
}
