// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;
import 'package:gallery_app/features/gallery/view/gallery_view.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    GalleryView.name: (routeData) {
      return _i2.AdaptivePage<void>(
        routeData: routeData,
        child: const _i1.GalleryView(),
      );
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/gallery',
          fullMatch: true,
        ),
        _i2.RouteConfig(
          GalleryView.name,
          path: '/gallery',
        ),
      ];
}

/// generated route for
/// [_i1.GalleryView]
class GalleryView extends _i2.PageRouteInfo<void> {
  const GalleryView()
      : super(
          GalleryView.name,
          path: '/gallery',
        );

  static const String name = 'GalleryView';
}
