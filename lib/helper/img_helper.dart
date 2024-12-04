import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';

class ImgHelper {
  static String placeholder =
      'https://firebasestorage.googleapis.com/v0/b/tmh-pos.appspot.com/o/Public%2Fbroken-image.png?alt=media&token=3a64f483-3061-4bc3-9bd1-4151b5656935';
  static Widget avatar(String? url,
      {double radius = 24,
      VoidCallback? onTap,
      Widget? child,
      ImageProvider? backgroundImage}) {
    return IconButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      icon: CircleAvatar(
        radius: radius,
        child: CircleAvatar(
          backgroundColor: xColor.inversePrimary,
          radius: radius - 2,
          backgroundImage: backgroundImage ??
              CachedNetworkImageProvider(url ??
                  'https://firebasestorage.googleapis.com/v0/b/ksedthan-tmh.appspot.com/o/public%2Fuser-128.png?alt=media'),
          child: child,
        ),
      ),
    );
  }

  static ImageProvider imageProvider(String? url) {
    return CachedNetworkImageProvider(url ?? placeholder);
  }
}
