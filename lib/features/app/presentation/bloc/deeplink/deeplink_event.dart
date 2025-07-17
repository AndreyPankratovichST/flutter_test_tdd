part of 'deeplink_bloc.dart';

@immutable
sealed class DeepLinkEvent {}

final class DeepLinkUpdateEvent extends DeepLinkEvent {
  final Uri? deeplink;
  DeepLinkUpdateEvent({required this.deeplink});
}
