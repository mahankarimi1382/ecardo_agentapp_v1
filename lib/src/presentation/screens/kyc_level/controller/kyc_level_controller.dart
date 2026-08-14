import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/src/helper/toast_helper.dart';
import 'package:flutter/src/network/api/api_path.dart';
import 'package:flutter/src/network/response/status.dart';
import 'package:flutter/src/network/service/network_service.dart';
import 'package:flutter/src/presentation/screens/kyc_level/model/kyc_level_model.dart';
import 'kyc_file_reader_stub.dart' if (dart.library.io) 'kyc_file_reader_io.dart';

class KycLevelController extends GetxController {
  final NetworkService _networkService = Get.find<NetworkService>();
  final RxBool isLoading = false.obs;
  final RxBool isSubmitting = false.obs;
  final RxList<KycLevel> levels = <KycLevel>[].obs;
  final Rxn<KycStatus> status = Rxn<KycStatus>();
  final Rxn<KycBadge> badge = Rxn<KycBadge>();

  @override
  void onInit() { super.onInit(); fetchStatus(); }

  Future<void> fetchLevels() async {
    isLoading.value = true;
    final response = await _networkService.get(endpoint: ApiPath.kycLevelLevelsEndpoint);
    isLoading.value = false;
    if (response.status == Status.completed) {
      final data = response.data?['data'] as List<dynamic>?;
      if (data != null) levels.value = data.map((e) => KycLevel.fromJson(e as Map<String, dynamic>)).toList();
    }
  }

  Future<void> fetchStatus() async {
    isLoading.value = true;
    final response = await _networkService.get(endpoint: ApiPath.kycLevelStatusEndpoint);
    isLoading.value = false;
    if (response.status == Status.completed) {
      final data = response.data?['data'] as Map<String, dynamic>?;
      if (data != null) { status.value = KycStatus.fromJson(data); badge.value = status.value!.badge; }
    }
    await fetchLevels();
  }

  Future<bool> submitDocuments({required Map<String, String> documents, int? targetLevel}) async {
    isSubmitting.value = true;
    try {
      final formData = <String, dynamic>{};
      if (targetLevel != null) formData['level'] = targetLevel.toString();
      for (final entry in documents.entries) {
        final fileName = entry.value.split('/').last;
        final mimeType = _getMimeType(fileName);
        final bytes = await KycFileReader.readBytes(entry.value);
        if (bytes != null) {
          formData['documents[\${entry.key}]'] = http_parser.MultipartFile.fromBytes(bytes, filename: fileName, contentType: MediaType.parse(mimeType));
        } else {
          formData['documents[\${entry.key}]'] = entry.value;
        }
      }
      final response = await _networkService.post(endpoint: ApiPath.kycLevelSubmitEndpoint, data: formData);
      isSubmitting.value = false;
      if (response.status == Status.completed) {
        ToastHelper().showSuccessToast(response.data?['data']?['message'] ?? 'Documents submitted.');
        await fetchStatus();
        return true;
      } else if (response.status == Status.error) {
        ToastHelper().showErrorToast(response.message ?? 'Submission failed.');
      }
    } catch (e) { isSubmitting.value = false; ToastHelper().showErrorToast('Failed: $e'); }
    return false;
  }

  bool hasFeature(String feature) => badge.value?.hasFeature(feature) ?? false;
  int get currentLevel => status.value?.currentLevel ?? 1;
  bool get isPending => status.value?.kycStatus == 'pending';
  bool get isRejected => status.value?.isRejected ?? false;
  KycNextLevel? get nextLevel => status.value?.nextLevel;

  String _getMimeType(String fileName) {
    final ext = fileName.toLowerCase().split('.').last;
    switch (ext) {
      case 'jpg': case 'jpeg': return 'image/jpeg';
      case 'png': return 'image/png';
      case 'pdf': return 'application/pdf';
      case 'gif': return 'image/gif';
      case 'webp': return 'image/webp';
      default: return 'application/octet-stream';
    }
  }
}
