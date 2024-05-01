import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/featuers/chats/repositories/messages_loading.dart';

class AudioLoading {
  final bool loading;

  AudioLoading(this.loading);
}

final AudioloadingProvider = StateProvider<Loading?>((ref) => null);
