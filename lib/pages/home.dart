// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:smart_foot_traffic_ui/components/summary_board.dart';
import 'package:smart_foot_traffic_ui/components/calendar_dropdown.dart';
import 'package:smart_foot_traffic_ui/components/dropdown_selector.dart';
import 'package:smart_foot_traffic_ui/components/appbar_button.dart';
import 'package:smart_foot_traffic_ui/components/zoom_button.dart';
import '../components/heatmap_view.dart';

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
  bool isDropdownOpen = false; // Track if any dropdown is open

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            toolbarHeight: 90,
            title: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/council_logo.png', height: 160),
                  const Spacer(),
                  AppBarButton(label: "Home", onPressed: () {}),
                  AppBarButton(label: "Location", onPressed: () {}),
                  AppBarButton(label: "Transport", onPressed: () {}),
                  AppBarButton(label: "Map", onPressed: () {}),
                  AppBarButton(label: "About", onPressed: () {}),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow[700],
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Register Now →"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
                      items: const ["None", "Pedestrian", "Vehicle", "Cyclist"],
                      selectedValue: selectedTrafficType ?? "None",
                      onChanged: (value) {
                        setState(() {
                          selectedTrafficType = value == "None" ? null : value;
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
                      items: const ["None", "12:00:00", "13:00:00"],
                      selectedValue: selectedTime ?? "None",
                      onChanged: (value) {
                        setState(() {
                          selectedTime = value == "None" ? null : value;
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
                        "None",
                        "Summer",
                        "Autumn",
                        "Winter",
                        "Spring"
                      ],
                      selectedValue: selectedSeason ?? "None",
                      onChanged: (value) {
                        setState(() {
                          selectedSeason = value == "None" ? null : value;
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
          "https://science.howstuffworks.com/environmental/earth/geophysics/map.htm"
          "?type=${selectedTrafficType ?? ''}"
          "&date=${selectedDate ?? ''}"
          "&time=${selectedTime ?? ''}"
          "&season=${selectedSeason ?? ''}";
    });

    print("Generate clicked with selections:");
    print("Traffic Type: $selectedTrafficType");
    print("Date: $selectedDate");
    print("Time: $selectedTime");
    print("Season: $selectedSeason");
  }
}
