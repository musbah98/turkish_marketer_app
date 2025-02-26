import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../decoration_and_assets/images.dart';

Widget cachedUrlImage({
  double? width,
  double? height,
  double? radius,
  BoxFit fit = BoxFit.cover,
  required String imageUrl,
  String? placeholderAsset = mockupImage, // Optional placeholder asset
  String? errorAsset = mockupImage, // Optional fallback asset on error
  String? altText, // Optional for accessibility
}) {
  // Check if the image is an SVG
  bool isSvg = imageUrl.toLowerCase().endsWith(".svg");

  if (isSvg) {
    // Load SVG image with fallback for error
    return FutureBuilder(
      future: _simulateSvgLoading(imageUrl), // Simulate the loading process
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading indicator or placeholder while SVG is loading
          return placeholderAsset != null
              ? Image.asset(placeholderAsset, width: width, height: height, fit: fit)
              : const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Show error widget or fallback asset on error
          return errorAsset != null
              ? Image.asset(errorAsset, width: width, height: height, fit: fit)
              : const Icon(Icons.error);
        } else {
          // Display SVG once loaded successfully
          return SvgPicture.network(
            imageUrl,
            width: width,
            height: height,
            fit: fit,
          );
        }
      },
    );
  } else {
    // Load regular (PNG/JPEG) image with CachedNetworkImage
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 0),
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
        width: width,
        height: height,
      ),
      placeholder: (context, url) => placeholderAsset != null
          ? Image.asset(placeholderAsset, width: width, height: height, fit: fit)
          : Center(child: const CircularProgressIndicator()), // Placeholder during loading
      errorWidget: (context, url, error) => errorAsset != null
          ? Image.asset(errorAsset, width: width, height: height, fit: fit)
          : const Icon(Icons.error), // Fallback on error
      width: width,
      height: height,
    );
  }
}

// Simulate an asynchronous task (like a network request for the SVG)
Future<void> _simulateSvgLoading(String url) async {
  await Future.delayed(const Duration(milliseconds: 500)); // Simulate network latency
  return; // Return nothing, just simulating the load
}
