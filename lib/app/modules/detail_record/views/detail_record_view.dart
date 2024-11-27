import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/models/disease/record/record_response.dart';
import 'package:heartrate_database_u_i/component/ui/download_header_widget.dart';
import '../controllers/detail_record_controller.dart';

class DetailRecordView extends GetView<DetailRecordController> {
  const DetailRecordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          // Show loading indicator if data is being fetched
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // Display error message if there is an error
          if (controller.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                controller.errorMessage.value,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // Show record details if available
          if (controller.recordDetail.value == null) {
            return const Center(
              child: Text('No record details available.'),
            );
          }

          final record = controller.recordDetail.value!.records;

          // Display the record details
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DownloadHeaderWidget(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Record ${record.id}',
                  style: const TextStyle(
                      fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                Card(
                  color: Colors.white,
                  elevation: 3,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var schema
                            in controller.recordDetail.value!.schema) ...[
                          // If the field is a file, create a row of buttons
                          if (schema.type == 'file')
                            ..._buildFileButtons(record, schema),
                          // Otherwise, display the field as text
                          if (schema.type != 'file')
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                '${schema.name}: ${record.getField(schema.name, schema) ?? 'No Data'}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                        ],
                      ],
                    ),
                  ),
                ),
                // Display fields dynamically

                const SizedBox(height: 20),
                // Export button
                ElevatedButton(
                  onPressed: () {
                    _exportRecord(record);
                  },
                  child: const Text('Export Record (CSV)'),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  /// Build file buttons if field type is 'file' and multiple is true
  List<Widget> _buildFileButtons(RecordDetail record, Schema schema) {
    var files = record.getField(schema.name, schema);

    if (files == null || (files is List && files.isEmpty)) {
      return [
        const Text('No files available'),
      ];
    }

    // If multiple files exist, return buttons for each file
    List<Widget> buttons = [];
    if (files is List) {
      for (var file in files) {
        String fileName = file.split('/').last;
        String fileExtension = fileName.split('.').last;

        buttons.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                _downloadFile(file);
              },
              child: Text('Download $fileExtension file'),
            ),
          ),
        );
      }
    } else {
      String fileName = files.split('/').last;
      String fileExtension = fileName.split('.').last;

      buttons.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ElevatedButton(
            onPressed: () {
              _downloadFile(files);
            },
            child: Text('Download $fileExtension file'),
          ),
        ),
      );
    }

    // Wrap the buttons inside a Wrap widget for better layout
    return [
      Wrap(
        spacing: 8.0, // Horizontal space between buttons
        runSpacing: 4.0, // Vertical space between rows of buttons
        children: buttons,
      ),
    ];
  }

  /// Function to download file
  Future<void> _downloadFile(String fileUrl) async {
    try {
      // Call the download method from your HttpService or FlutterDownloader
      print("Downloading file: $fileUrl");
      // You can use your existing logic to download the file
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to download file: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Function to export the record as a CSV file
  Future<void> _exportRecord(RecordDetail record) async {
    try {
      // Here you can define the logic to export the record to a CSV file.
      // For example, you could call a method in your service to fetch the export URL.
      String exportUrl = record.exportUrl; // Assuming exportUrl is available

      if (exportUrl.isNotEmpty) {
        // Initiate download or export logic (e.g., using FlutterDownloader or custom logic)
        print("Exporting record to: $exportUrl");
        _downloadFile(exportUrl); // Example method to download the file
      } else {
        Get.snackbar(
          "Error",
          "Export URL is not available.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to export record: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print("Error exporting record: $e");
    }
  }
}
