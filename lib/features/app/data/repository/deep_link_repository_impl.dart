import 'dart:async';

import 'package:flutter_test_tdd/features/app/data/source/deep_link_platform_source.dart';
import 'package:flutter_test_tdd/features/app/domain/repository/deep_link_repository.dart';

class DeepLinkRepositoryImpl extends DeepLinkRepository {
  final DeepLinkPlatformSource _deepLinkPlatformSource;

  DeepLinkRepositoryImpl(this._deepLinkPlatformSource);

  @override
  Stream<Uri?> getDeepLinkStream() =>
      _deepLinkPlatformSource.getDeepLinkStream().transform(
        StreamTransformer.fromHandlers(
          handleData: (data, sink) => sink.add(Uri.tryParse(data)),
        ),
      );

  @override
  Future<Uri?> getInitialDeepLink() async {
    final deepLink = await _deepLinkPlatformSource.getInitialDeepLink();
    return Uri.tryParse(deepLink ?? '');
  }
}
