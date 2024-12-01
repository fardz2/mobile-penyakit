import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';

class GridItem extends StatelessWidget {
  final String icon;
  final String title;
  final List<String> content;
  final String titleContent;

  const GridItem({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
    required this.titleContent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: SingleChildScrollView(
              // Allow scrolling if content is too large
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Get.back(); // Close Bottom Sheet
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: customColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: SvgPicture.asset(
                                icon,
                                width: 20,
                                height: 20,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              // Use Expanded to prevent overflow
                              child: Text(
                                titleContent,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        content.length > 1
                            ? _buildPageViewWithButtons(content)
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                          children: _parseContent(content[0]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(color: customColor.withOpacity(0.5), width: 1),
            ),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: customColor,
              ),
              child: SvgPicture.asset(
                icon,
                width: 20,
                height: 20,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build PageView with navigation buttons
  Widget _buildPageViewWithButtons(List<String> content) {
    PageController pageController = PageController();
    var currentPage = 0.obs;

    return Column(
      children: [
        SizedBox(
          height: 100,
          child: PageView.builder(
            controller: pageController,
            itemCount: content.length,
            onPageChanged: (index) {
              currentPage.value = index; // Update current page index
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Menampilkan angka
                    Text(
                      '${index + 1}.', // Menampilkan angka
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          children: _parseContent(content[index]),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: currentPage.value > 0
                        ? customColor
                        : customColor.withOpacity(
                            0.5), // Background color based on state
                    borderRadius:
                        BorderRadius.circular(50), // Full radius for pill shape
                  ),
                  child: IconButton(
                    onPressed: currentPage.value > 0
                        ? () {
                            pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          }
                        : null,
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 8), // Space between buttons
                Container(
                  decoration: BoxDecoration(
                    color: currentPage.value < content.length - 1
                        ? customColor
                        : customColor.withOpacity(
                            0.5), // Background color based on state
                    borderRadius:
                        BorderRadius.circular(50), // Full radius for pill shape
                  ),
                  child: IconButton(
                    onPressed: currentPage.value < content.length - 1
                        ? () {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          }
                        : null,
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  // Helper function to parse content and make text before \n bold
  List<TextSpan> _parseContent(String text) {
    List<TextSpan> textSpans = [];
    List<String> parts = text.split('\n');

    if (parts.length == 1) {
      textSpans.add(TextSpan(
        text: parts[0],
        style: const TextStyle(fontSize: 14), // Default style for single line
      ));
    } else {
      for (int i = 0; i < parts.length; i++) {
        if (i == 0) {
          textSpans.add(TextSpan(
            text: parts[i],
            style: const TextStyle(fontWeight: FontWeight.bold), // Bold text
          ));
        } else {
          textSpans.add(TextSpan(text: '\n' + parts[i]));
        }
      }
    }

    return textSpans;
  }
}
