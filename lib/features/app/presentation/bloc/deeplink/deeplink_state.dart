part of 'deeplink_bloc.dart';

@immutable
sealed class DeeplinkState {}

final class DeeplinkInitial extends DeeplinkState {}

final class DeeplinkLoaded extends DeeplinkState {
  final String? url;

  DeeplinkLoaded(this.url);
}
