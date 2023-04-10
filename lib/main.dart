import 'package:atomsbox/atomsbox.dart';
import 'package:flutter/material.dart';

import 'animations/animations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: AppText.headlineSmall(
          'Animations with Flutter',
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppConstants.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppElevatedButton(
              minimumSize: const Size(200, 45),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BlurAnimationExample(),
                  ),
                );
              },
              child: AppText.bodyLarge('Blur Effect'),
            ),
            const SizedBox(height: AppConstants.md),
            AppElevatedButton(
              minimumSize: const Size(200, 45),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FadeAnimationExample(),
                  ),
                );
              },
              child: AppText.bodyLarge('Fade Effect'),
            ),
            const SizedBox(height: AppConstants.md),
            AppElevatedButton(
              minimumSize: const Size(200, 45),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RotateAnimationExample(),
                  ),
                );
              },
              child: AppText.bodyLarge('Rotate Effect'),
            ),
            const SizedBox(height: AppConstants.md),
            AppElevatedButton(
              minimumSize: const Size(200, 45),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShakeAnimationExample(),
                  ),
                );
              },
              child: AppText.bodyLarge('Shake Effect'),
            ),
            const SizedBox(height: AppConstants.md),
            AppElevatedButton(
              minimumSize: const Size(200, 45),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SlideAnimationExample(),
                  ),
                );
              },
              child: AppText.bodyLarge('Slide Effect'),
            ),
          ],
        ),
      ),
    );
  }
}
