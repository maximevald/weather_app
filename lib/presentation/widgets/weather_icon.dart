import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({
    required this.id,
    super.key,
    this.scale = 4,
    this.size = 300,
  });
  static const url = 'https://openweathermap.org/img/wn/';
  final String id;
  final int scale;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: '$url$id@${scale}x.png',
      fit: BoxFit.contain,
      width: size,
      height: size,
    );
  }
}
