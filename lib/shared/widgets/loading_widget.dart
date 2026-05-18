import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget.listTile({super.key}) : isCard = false;

  const LoadingWidget.card({super.key}) : isCard = true;

  final bool isCard;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      highlightColor: Theme.of(context).colorScheme.surface,
      child: isCard ? const _CardLoading() : const _ListTileLoading(),
    );
  }
}

class _ListTileLoading extends StatelessWidget {
  const _ListTileLoading();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          _PlaceholderBox(width: 48, height: 48, radius: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PlaceholderBox(width: double.infinity, height: 14),
                SizedBox(height: 8),
                _PlaceholderBox(width: 160, height: 12),
              ],
            ),
          ),
          SizedBox(width: 12),
          _PlaceholderBox(width: 64, height: 24, radius: 12),
        ],
      ),
    );
  }
}

class _CardLoading extends StatelessWidget {
  const _CardLoading();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PlaceholderBox(width: double.infinity, height: 120, radius: 12),
            SizedBox(height: 12),
            _PlaceholderBox(width: double.infinity, height: 16),
            SizedBox(height: 8),
            _PlaceholderBox(width: 120, height: 14),
            SizedBox(height: 14),
            _PlaceholderBox(width: 96, height: 28, radius: 14),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderBox extends StatelessWidget {
  const _PlaceholderBox({
    required this.width,
    required this.height,
    this.radius = 8,
  });

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
