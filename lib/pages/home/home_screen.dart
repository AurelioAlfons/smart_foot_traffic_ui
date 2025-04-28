// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:smart_foot_traffic_ui/components/appbar_state.dart';
import 'package:smart_foot_traffic_ui/components/summary_board.dart';
import 'package:smart_foot_traffic_ui/components/calendar_dropdown.dart';
import 'package:smart_foot_traffic_ui/components/dropdown_selector.dart';
import 'package:smart_foot_traffic_ui/components/zoom_button.dart';
import '../../components/heatmap_view.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(onHomePressed: resetState),
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
                    _buildDatePickerButton(),
                    const SizedBox(width: 16),
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
                    ZoomButton(url: heatmapUrl),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
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
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
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
    );
  }

  void generateHeatmap() {
    setState(() {
      heatmapUrl =
          // Aurelio: Home Wifi
          "http://192.168.1.118:5000/heatmaps/heatmap_2025-02-27_01-00-00_Vehicle_Count.html";
    });

    print("Generate clicked with selections:");
    print("Traffic Type: $selectedTrafficType");
    print("Date: $selectedDate");
    print("Time: $selectedTime");
    print("Season: $selectedSeason");
  }

  // 👇 ADD this at the end
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
