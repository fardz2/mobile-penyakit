import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/models/disease/record/record_response.dart';

import 'package:heartrate_database_u_i/component/ui/download_button.dart';
import 'package:heartrate_database_u_i/component/ui/download_header_widget.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';
import '../controllers/detail_record_controller.dart';
import 'package:heartrate_database_u_i/utils/file_downloader.dart'; // Import FileDownloader

class DetailRecordView extends GetView<DetailRecordController> {
  const DetailRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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

          final recordResponse = controller.recordDetail.value!;
          final record = recordResponse.records;

          // Check if there are any non-file records
          bool hasNonFileRecords =
              recordResponse.schema.any((schema) => schema.type != 'file');

          // Display the record details
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DownloadHeaderWidget(
                  name: controller.name,
                ),
                const SizedBox(height: 20),
                Text(
                  'Record ${record.id}',
                  style: const TextStyle(
                      fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Only show the card if there are non-file records
                if (hasNonFileRecords)
                  Card(
                    color: Colors.white,
                    elevation: 3,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    child: Container(
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var schema in recordResponse.schema) ...[
                              // Check if the schema type is not 'file'
                              if (schema.type != 'file')
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(
                                    // Create the label string
                                    "${schema.name}\t: ${record.fields[schema.name] ?? 'No Data'}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 20),
                // Wrap for file buttons and export button
                Wrap(
                  spacing: 8.0, // Horizontal space between buttons
                  runSpacing: 4.0, // Vertical space between rows of buttons
                  children: [
                    for (var schema in recordResponse.schema) ...[
                      if (schema.type == 'file')
                        ..._buildFileButtons(record, schema),
                    ],
                    // Use the DownloadButton for exporting CSV
                    DownloadButton(
                      fileName: 'CSV File',
                      fileUrl: record.exportUrl,
                      buttonName: 'Export CSV',
                      customColor: customColor, // Set your custom color here
                      onPressed: () async {
                        if (record.exportUrl.isNotEmpty) {
                          await FileDownloader.downloadFile(
                            record.exportUrl,
                            controller.name + record.id.toString(),
                            useBearer: true,
                          );
                        } else {
                          Get.snackbar(
                            "Info",
                            "Export URL tidak tersedia.",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.amber,
                            colorText: Colors.black,
                          );
                        }
                      },
                    ),
                  ],
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
    var files = record.fields[schema.name]; // Accessing files from fields

    if (files == null || (files is List && files.isEmpty)) {
      return [
        const Text('No files available'),
      ];
    }

    List<Widget> buttons = [];
    Map<String, int> fileCount = {}; // To track counts of each file extension

    if (files is List) {
      for (var file in files) {
        String fileName = file.split('/').last;
        String fileExtension = fileName.split('.').last;

        // Initialize the count for this extension if not already done
        if (!fileCount.containsKey(fileExtension)) {
          fileCount[fileExtension] = 0;
        }
        fileCount[fileExtension] =
            (fileCount[fileExtension] ?? 0) + 1; // Safely increment the count

        // Create a unique button name
        String buttonName = fileCount[fileExtension] == 1
            ? '$fileExtension file'
            : '$fileExtension${fileCount[fileExtension]} file';

        buttons.add(
          DownloadButton(
            fileName: fileName,
            fileUrl: file,
            buttonName: buttonName,
            customColor: customColor, // Set your custom color here
            onPressed: () async {
              await FileDownloader.downloadFile(
                  file, controller.name + controller.recordId,
                  useBearer: false);
            },
          ),
        );
      }
    } else {
      String fileName = files.split('/').last;
      String fileExtension = fileName.split('.').last;

      // Initialize the count for this extension if not already done
      if (!fileCount.containsKey(fileExtension)) {
        fileCount[fileExtension] = 0;
      }
      fileCount[fileExtension] =
          (fileCount[fileExtension] ?? 0) + 1; // Safely increment the count

      // Create a unique button name
      String buttonName = fileCount[fileExtension] == 1
          ? '$fileExtension '
          : '${fileExtension}${fileCount[fileExtension]}';

      buttons.add(
        DownloadButton(
          fileName: fileName,
          fileUrl: files,
          buttonName: buttonName,
          customColor: customColor, // Set your custom color here
          onPressed: () async {
            await FileDownloader.downloadFile(
                files, controller.name + controller.recordId,
                useBearer: true);
          },
        ),
      );
    }

    // Return the buttons
    return buttons;
  }
}
