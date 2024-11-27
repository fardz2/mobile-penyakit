import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/models/disease/record/record_response.dart';
import 'package:heartrate_database_u_i/utils/api/disease/record/disease_record.dart';

class DetailRecordController extends GetxController {
  var isLoading = true.obs;
  var recordDetail = Rx<RecordResponseDetail?>(null);
  var errorMessage = ''.obs;

  final String penyakitId = Get.arguments['penyakit_id'].toString();
  final String recordId = Get.arguments['record_id'].toString();

  @override
  void onInit() {
    super.onInit();
    getDetailRecord();
  }

  Future<void> getDetailRecord() async {
    try {
      isLoading(true);
      errorMessage('');

      // Fetch record details using the service
      final recordResponse = await DiseaseRecordService().getDetailRecord(
        int.parse(penyakitId),
        int.parse(recordId),
      );

      // Update the observable with fetched data
      recordDetail.value = recordResponse;
    } catch (e) {
      errorMessage('Failed to load record details: $e');
    } finally {
      isLoading(false);
    }
  }
}