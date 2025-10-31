import 'package:flutter_test_tdd/features/biometry/provider/biometry_provider.dart';
import 'package:flutter_test_tdd/features/listing/provider/listing_provider.dart';
import 'package:provider/provider.dart';

List<MultiProvider> homeGroup = [
  biometryProvider,
  listingProvider,
];