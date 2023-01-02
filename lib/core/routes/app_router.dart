import 'package:auto_route/annotations.dart';
import 'package:gallery_app/features/gallery/view/gallery_view.dart';

import 'app_routes.dart';

export 'app_router.gr.dart';
export 'app_routes.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute<void>(initial: true, page: GalleryView, path: AppRoutes.gallery),
  ],
)
class $AppRouter {}
