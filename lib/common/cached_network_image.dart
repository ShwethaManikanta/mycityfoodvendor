import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NetworkImageView extends StatelessWidget {
  const NetworkImageView({
    Key? key,
    required this.photoUrl,
    required this.radius,
    required this.borderColor,
    required this.borderWidth,
    this.onPressed,
  }) : super(key: key);
  final String photoUrl;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: photoUrl == null
          ? Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
                border: Border.all(color: borderColor, width: borderWidth),
              ),
              child: Icon(Icons.add_a_photo),
            )
          : CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: photoUrl,
              placeholder: (context, string) {
                return Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(radius)),
                    border: Border.all(color: borderColor, width: borderWidth),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              imageBuilder: (context, imageProvider) => Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(radius)),
                  border: Border.all(color: borderColor, width: borderWidth),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
    );
  }
}

class NetworkImageViewWithSize extends StatelessWidget {
  const NetworkImageViewWithSize({
    Key? key,
    required this.photoUrl,
    required this.radius,
    required this.borderColor,
    required this.borderWidth,
    this.onPressed,
  }) : super(key: key);
  final String photoUrl;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: photoUrl == null
          ? Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: borderWidth),
              ),
            )
          : CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: photoUrl,
              placeholder: (context, string) {
                return Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: borderColor, width: borderWidth),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              imageBuilder: (context, imageProvider) => Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor, width: borderWidth),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
    );
  }
}

Widget cachedNetworkImage(double height, double width, String imageUrl,
    {double opacity = 0, double radius = 8}) {
  return CachedNetworkImage(
      height: height,
      width: width,
      fit: BoxFit.cover,
      imageUrl: (imageUrl),
      placeholder: (context, string) {
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 1,
          ),
        );
      },
      imageBuilder: (context, imageProvider) => Container(
            // height: 100,
            // width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              border: Border.all(color: Colors.white),
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(opacity), BlendMode.srcOver),
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ));
}

class NetworkImageViewWithHeightWidth extends StatelessWidget {
  const NetworkImageViewWithHeightWidth({
    Key? key,
    required this.photoUrl,
    required this.radius,
    required this.borderColor,
    required this.borderWidth,
    required this.width,
    required this.height,
    this.onPressed,
  }) : super(key: key);
  final String? photoUrl;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final double height, width;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: photoUrl == null
          ? Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: borderWidth),
              ),
            )
          : CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: photoUrl!,
              placeholder: (context, string) {
                return Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: borderColor, width: borderWidth),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  ),
                );
              },
              imageBuilder: (context, imageProvider) => Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor, width: borderWidth),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
    );
  }
}

class NetworkImageViewWithHeightWidthWithBorderRadius extends StatelessWidget {
  const NetworkImageViewWithHeightWidthWithBorderRadius({
    Key? key,
    required this.photoUrl,
    required this.radius,
    required this.borderColor,
    required this.borderWidth,
    required this.width,
    required this.height,
    this.onPressed,
  }) : super(key: key);
  final String? photoUrl;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final double height, width;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: photoUrl == null
          ? Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  border: Border.all(color: borderColor, width: borderWidth),
                  borderRadius: BorderRadius.circular(radius)),
            )
          : CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: photoUrl!,
              placeholder: (context, string) {
                return Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(color: borderColor, width: borderWidth),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  ),
                );
              },
              imageBuilder: (context, imageProvider) => Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(color: borderColor, width: borderWidth),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
    );
  }
}
