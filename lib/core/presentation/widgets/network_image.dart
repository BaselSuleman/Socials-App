import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:micropolis_assessment/core/presentation/widgets/svg_icon.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../resources/assets.gen.dart';

class CustomNetworkImage extends StatefulWidget {
  const CustomNetworkImage({
    super.key,
    required this.url,
    this.localImage,
    this.boxFit,
    this.borderRadius,
    this.filterQuality,
    this.height,
    this.width,
    this.onPress,
    this.alignment,
    this.colorFilter,
    this.enableCache = false,
    this.isLocalFile = false,
    this.useSkeletonizer = true,
    this.opacity,
    this.errorIcon,
  });

  final String url;
  final String? errorIcon;
  final String? localImage;
  final BoxFit? boxFit;
  final BorderRadius? borderRadius;
  final double? height;
  final FilterQuality? filterQuality;
  final double? width;
  final double? opacity;
  final bool enableCache;
  final bool isLocalFile;
  final bool useSkeletonizer;
  final ColorFilter? colorFilter;
  final Alignment? alignment;
  final VoidCallback? onPress;

  @override
  State<CustomNetworkImage> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.localImage != null && File(widget.localImage!).existsSync()) {
      return _buildLocalImage(context);
    }

    return Opacity(
      opacity: widget.opacity ?? 1,
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: widget.url,
          alignment: widget.alignment ?? Alignment.topCenter,
          height: widget.height,
          width: widget.width,
          memCacheHeight: widget.enableCache
              ? (((widget.height) ?? 1) *
                        MediaQuery.of(context).devicePixelRatio)
                    .round()
              : null,
          memCacheWidth: widget.enableCache
              ? (((widget.width) ?? 1) *
                        MediaQuery.of(context).devicePixelRatio)
                    .round()
              : null,
          filterQuality: widget.filterQuality ?? FilterQuality.low,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: widget.boxFit ?? BoxFit.cover,
                colorFilter: widget.colorFilter,
              ),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
            ),
          ),
          errorWidget: (context, error, stackTrace) {
            return _buildErrorWidget();
          },
          placeholder: (context, loadingProgress) => widget.useSkeletonizer
              ? _buildPlaceholder()
              : _buildNormalPlaceholder(),
          fit: widget.boxFit ?? BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLocalImage(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
      child: Image.file(
        File(widget.localImage!),
        height: widget.height,
        width: widget.width,
        alignment: widget.alignment ?? Alignment.topCenter,
        fit: widget.boxFit ?? BoxFit.cover,
        filterQuality: widget.filterQuality ?? FilterQuality.low,
      ),
    );
  }

  Widget _buildPlaceholder() {
    final double size = widget.height ?? 80.0;
    final double padding = 3.0;
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Skeletonizer(
        effect: ShimmerEffect(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          duration: Duration(seconds: 1),
        ),
        child: ClipRRect(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
          child: Container(
            height: size,
            width: size,
            color: Colors.grey.shade100,
          ),
        ),
      ),
    );
  }

  Widget _buildNormalPlaceholder() {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Center(child: CupertinoActivityIndicator(color: Colors.white)),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      height: widget.height,
      width: widget.width,
      color: Colors.grey.shade100,
      child: Center(
        child: CustomSvgIcon(widget.errorIcon ?? Assets.icons.imageError),
      ),
    );
  }
}
