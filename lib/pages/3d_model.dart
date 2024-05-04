import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:flutter/material.dart';

class Model3D extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("BabylonJS Viewer")),
        body: Column(
          children: [
            OutlinedButton(
              onPressed: () {
                print("wadawdawdawd");
              },
              style: OutlinedButton.styleFrom(
                fixedSize:
                    Size.fromHeight(MediaQuery.of(context).size.height - 100),
              ),
              child: Container(
                height: 300,
                child: ModelViewer(
                  backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
                  src: 'assets/models/chair.glb',
                  alt: 'A 3D model of an astronaut',
                  ar: true,
                  arModes: ['scene-viewer', 'webxr', 'quick-look'],
                  autoRotate: true,
                  iosSrc:
                      'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
                  disableZoom: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
