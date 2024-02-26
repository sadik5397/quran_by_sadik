import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/pr_sura.dart';

class AnimatedPlayPauseIcon extends StatefulWidget {
  const AnimatedPlayPauseIcon({super.key, required this.index});

  final int index;

  @override
  AnimatedPlayPauseIconState createState() => AnimatedPlayPauseIconState();
}

class AnimatedPlayPauseIconState extends State<AnimatedPlayPauseIcon> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderSurah>(context);
    final animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    provider.isPlaying[widget.index] ? _animationController.forward() : _animationController.reverse();
    return provider.isLoading[widget.index] ? const CircularProgressIndicator() : AnimatedIcon(icon: AnimatedIcons.play_pause, progress: animation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
