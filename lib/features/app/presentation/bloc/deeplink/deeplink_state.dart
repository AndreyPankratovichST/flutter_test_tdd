part of 'deeplink_bloc.dart';

@immutable
sealed class DeepLinkState {}

final class DeepLinkInitial extends DeepLinkState {}

final class DeepLinkLoaded extends DeepLinkState {
  final Uri url;

  DeepLinkLoaded(this.url);
}
