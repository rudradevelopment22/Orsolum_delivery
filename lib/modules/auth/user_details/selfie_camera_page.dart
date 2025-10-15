import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

class SelfieCameraPage extends StatefulWidget {
  const SelfieCameraPage({super.key});

  @override
  _SelfieCameraPageState createState() => _SelfieCameraPageState();
}

class _SelfieCameraPageState extends State<SelfieCameraPage> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    await Permission.camera.request();
    cameras = await availableCameras();
    final frontCamera = cameras!.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    _cameraController = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _cameraController!.initialize();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: CameraPreview(_cameraController!)),

          // Circular Overlay
          Container(
            color: Colors.black54,
            child: Center(
              child: ClipOval(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),

          // Instructions
          Positioned(
            bottom: 160,
            left: 0,
            right: 0,
            child: Column(
              children: const [
                Text(
                  "Centre your face",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Align your face to the center of the selfie area",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Capture + Buttons
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.flash_on, color: Colors.white, size: 32),

                // Capture Button
                GestureDetector(
                  onTap: () async {
                    final image = await _cameraController!.takePicture();
                    if (!mounted) return;
                    Get.back(result: image); // return XFile via GetX
                  },
                  child: const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                  ),
                ),

                const Icon(Icons.cameraswitch, color: Colors.white, size: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
