import 'package:flutter/material.dart';
import '../../../../data/image_path.dart';
import '../../../../utils/app_size.dart';
import '../../../../widgets/default_custom_clipper.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipPath(
            clipper: DefaultCustomClipper(),
            child: Image.asset(
              ImagePath.onboardingImage,
              fit: BoxFit.fitWidth,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(Icons.image, size: 50.sp, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
