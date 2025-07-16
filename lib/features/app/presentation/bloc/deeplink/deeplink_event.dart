part of 'deeplink_bloc.dart';

@immutable
sealed class DeepLinkEvent {}

final class DeepLinkInitialEvent extends DeepLinkEvent {}

final class DeepLinkUpdateEvent extends DeepLinkEvent {
  final String deeplink;
  DeepLinkUpdateEvent({required this.deeplink});
}
