import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 227, 227),
      body: Center(
        child: SpinKitSquareCircle(
          itemBuilder: (context, index) => Image.network(
              fit: BoxFit.cover,
              'https://dm0qx8t0i9gc9.cloudfront.net/thumbnails/video/VCHXZQKsxil3lhgr4/videoblocks-loading-circle-icon-background_hzgpttyxpm_thumbnail-1080_01.png'),
          size: 70,
          color: Colors.blue,
        ),
      ),
    );
  }
}
