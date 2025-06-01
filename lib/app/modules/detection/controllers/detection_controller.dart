import 'dart:typed_data';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class DetectionController extends GetxController {
  late Interpreter interpreter;
  List<String> labels = [];

  CameraController? cameraController;
  List<CameraDescription> cameras = [];
  int selectedCameraIndex = 0;
  var isCameraInitialized = false.obs;

  final faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      performanceMode: FaceDetectorMode.fast,
      enableLandmarks: true,
    ),
  );

  var predictedLabel = 'unknown'.obs;
  bool isDetecting = false;

  @override
  void onInit() {
    super.onInit();
    loadModel();
  }

  @override
  void onClose() {
    cameraController?.stopImageStream();
    cameraController?.dispose();
    interpreter.close();
    super.onClose();
  }

  Future<void> loadModel() async {
    try {
      interpreter =
          await Interpreter.fromAsset('assets/models/model_drowsy.tflite');
      final labelData = await rootBundle.loadString('assets/labels/label.txt');
      labels = labelData.split('\n').where((e) => e.trim().isNotEmpty).toList();
      debugPrint('✅ Model loaded with ${labels.length} labels');
      var inputShape = interpreter.getInputTensor(0).shape;
      print("Model input shape: $inputShape"); // contoh output: [1, 48, 48, 3]
    } catch (e) {
      debugPrint('❌ Error loading model: $e');
    }
  }

  Future<void> startCamera() async {
    cameras = await availableCameras();
    await initializeCamera(selectedCameraIndex);
  }

  Uint8List convertYUV420toNV21(CameraImage image) {
    final int width = image.width;
    final int height = image.height;
    final int uvRowStride = image.planes[1].bytesPerRow;
    final int uvPixelStride = image.planes[1].bytesPerPixel ?? 1;

    final ySize = width * height;
    final uvSize = width * height ~/ 2;
    final nv21 = Uint8List(ySize + uvSize);

    // Copy Y plane
    final yPlane = image.planes[0].bytes;
    nv21.setRange(0, ySize, yPlane);

    // U and V planes are interleaved in NV21 format as VU VU VU...
    int uvIndex = ySize;
    final uPlane = image.planes[1].bytes;
    final vPlane = image.planes[2].bytes;

    for (int i = 0; i < height ~/ 2; i++) {
      for (int j = 0; j < width ~/ 2; j++) {
        final uPos = i * uvRowStride + j * uvPixelStride;
        final vPos = i * uvRowStride + j * uvPixelStride;
        nv21[uvIndex++] = vPlane[vPos]; // V
        nv21[uvIndex++] = uPlane[uPos]; // U
      }
    }
    return nv21;
  }

  Future<void> stopCamera() async {
    await cameraController?.stopImageStream();
    await cameraController?.dispose();
    cameraController = null;
    isCameraInitialized.value = false;
    predictedLabel.value = 'unknown';
  }

  Future<void> switchCamera() async {
    if (cameras.isEmpty) {
      cameras = await availableCameras();
    }
    selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length;
    await stopCamera();
    await initializeCamera(selectedCameraIndex);
  }

  Future<void> initializeCamera(int cameraIndex) async {
    try {
      final selectedCamera = cameras[cameraIndex];
      cameraController = CameraController(
        selectedCamera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await cameraController!.initialize();
      await cameraController!.startImageStream(processCameraImage);
      isCameraInitialized.value = true;
    } catch (e) {
      debugPrint('❌ Camera init error: $e');
    }
  }

  void processCameraImage(CameraImage image) async {
    if (isDetecting) return;
    isDetecting = true;

    try {
      final bytes = convertYUV420toNV21(image);

      final rotation = InputImageRotationValue.fromRawValue(
              cameraController!.description.sensorOrientation) ??
          InputImageRotation.rotation0deg;

      final inputImageFormat =
          InputImageFormatValue.fromRawValue(InputImageFormat.nv21.rawValue);

      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: rotation,
          format: inputImageFormat!,
          bytesPerRow: image.planes[0].bytesPerRow,
        ),
      );

      final faces = await faceDetector.processImage(inputImage);

      if (faces.isNotEmpty) {
        final face = faces.first;
        final inputSize = 224;

        // Panggil hanya sekali
        final inputFloat32 = cropAndResizeFaceFromCameraImage(
            image, face.boundingBox, inputSize);

        // Input harus 4D: [1, inputSize, inputSize, 1]
        var input = inputFloat32.reshape([1, inputSize, inputSize, 3]);

        var output = List.generate(1, (_) => List.filled(1, 0.0));

        interpreter.run(input, output);

        double score = output[0][0];

        predictedLabel.value = score > 0.5 ? labels[1] : labels[0];
        print("⚙️ Score: $score => ${predictedLabel.value}");
      } else {
        predictedLabel.value = 'unknown';
      }
    } catch (e) {
      debugPrint("❌ Detection error: $e");
      predictedLabel.value = 'unknown';
    } finally {
      isDetecting = false;
    }
  }

  Float32List cropAndResizeFaceFromCameraImage(
      CameraImage image, Rect boundingBox, int inputSize) {
    final width = image.width;
    final height = image.height;
    final imgImage = img.Image(width: width, height: height);

    // Ambil channel Y (grayscale) dulu, supaya bisa gabung dengan UV nanti, tapi
    // lebih simpel kita buat langsung warna grayscale dulu karena kamu pakai planes[0] saja
    // Tapi sebaiknya pakai NV21 atau YUV ke RGB conversion dulu.

    // Karena kamu pakai img.Image, lebih baik convert CameraImage ke RGB dulu.
    // Tapi supaya sederhana, saya langsung contohkan fill pixel grayscale ke R=G=B.

    final Plane plane = image.planes[0];
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final index = y * plane.bytesPerRow + x;
        final pixel = plane.bytes[index];
        // R=G=B karena grayscale source, set RGB all sama pixel value
        imgImage.setPixelRgb(x, y, pixel, pixel, pixel);
      }
    }

    final x = boundingBox.left.toInt().clamp(0, width - 1);
    final y = boundingBox.top.toInt().clamp(0, height - 1);
    final boxWidth = boundingBox.width.toInt().clamp(1, width - x);
    final boxHeight = boundingBox.height.toInt().clamp(1, height - y);

    final faceCrop =
        img.copyCrop(imgImage, x: x, y: y, width: boxWidth, height: boxHeight);
    final resized =
        img.copyResize(faceCrop, width: inputSize, height: inputSize);

    // Buat Float32List dengan panjang inputSize * inputSize * 3 (R,G,B)
    final input = Float32List(inputSize * inputSize * 3);

    for (int i = 0; i < inputSize; i++) {
      for (int j = 0; j < inputSize; j++) {
        final pixel = resized.getPixel(j, i);
        final r = pixel.r;
        final g = pixel.g;
        final b = pixel.b;

        final baseIndex = (i * inputSize + j) * 3;
        input[baseIndex] = r / 255.0;
        input[baseIndex + 1] = g / 255.0;
        input[baseIndex + 2] = b / 255.0;
      }
    }

    return input;
  }
}
