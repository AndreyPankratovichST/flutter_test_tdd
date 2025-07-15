part of 'deeplink_bloc.dart';

@immutable
sealed class DeeplinkEvent {}

final class DeeplinkInitialEvent extends DeeplinkEvent {}

final class DeeplinkUpdateEvent extends DeeplinkEvent {
  final String deeplink;
  DeeplinkUpdateEvent({required this.deeplink});
}
