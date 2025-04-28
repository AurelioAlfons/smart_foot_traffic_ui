// ignore_for_file: avoid_print, undefined_prefixed_name, duplicate_ignore, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import '../components/heatmap_view.dart';
import '../components/summary_board.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedTrafficType;
  String? selectedLocation;
  String? selectedDate;
  String? selectedTime;
  String? selectedSeason;

  String heatmapUrl = "https://aurelioalfons.github.io/aurelio_portfolio_html/";

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
                color: Colors.black.withOpacity(0.05), // Soft black shadow
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
                  Image.asset(
                    'assets/images/council_logo.png',
                    height: 160,
                  ),
                  const SizedBox(width: 10),
                  const Spacer(),
                  _buildAppBarButton("Home"),
                  _buildAppBarButton("Location"),
                  _buildAppBarButton("Transport"),
                  _buildAppBarButton("Map"),
                  _buildAppBarButton("About"),
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
      body: Column(
        children: [
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 16),
                _buildDropdown(
                    "Traffic Type",
                    ["Pedestrian Count", "Vehicle Count", "Cyclist Count"],
                    selectedTrafficType, (value) {
                  setState(() {
                    selectedTrafficType = value;
                  });
                }),
                const SizedBox(width: 16),
                _buildDropdown("Location", ["Footscray", "City Center", "West"],
                    selectedLocation, (value) {
                  setState(() {
                    selectedLocation = value;
                  });
                }),
                const SizedBox(width: 16),
                _buildDropdown(
                    "Date", ["2025-02-27", "2025-03-03"], selectedDate,
                    (value) {
                  setState(() {
                    selectedDate = value;
                  });
                }),
                const SizedBox(width: 16),
                _buildDropdown("Time", ["12:00:00", "13:00:00"], selectedTime,
                    (value) {
                  setState(() {
                    selectedTime = value;
                  });
                }),
                const SizedBox(width: 16),
                _buildDropdown(
                    "Season",
                    ["Summer", "Autumn", "Winter", "Spring"],
                    selectedSeason, (value) {
                  setState(() {
                    selectedSeason = value;
                  });
                }),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[900],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: generateHeatmap,
                  child: const Text("Generate →"),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: HeatmapView(url: heatmapUrl),
                ),
                const Expanded(
                  flex: 1,
                  child: SummaryBoard(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? selectedValue,
      ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      value: selectedValue,
      hint: Text(label),
      dropdownColor: Colors.yellow[50],
      style: const TextStyle(color: Colors.black, fontSize: 16),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildAppBarButton(String label) {
    return TextButton(
      onPressed: () {},
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void generateHeatmap() {
    setState(() {
      heatmapUrl = "https://aurelioalfons.github.io/aurelio_portfolio_html/";
    });

    print("Generate clicked with selections:");
    print("Traffic Type: $selectedTrafficType");
    print("Location: $selectedLocation");
    print("Date: $selectedDate");
    print("Time: $selectedTime");
    print("Season: $selectedSeason");
  }
}
