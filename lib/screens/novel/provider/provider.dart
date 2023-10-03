import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kagayaku_modules/kagayaku_modules.dart';

class NovelDetails {
  const NovelDetails();
}

class NovelDetailsState {
  NovelDetailsState();

  KagayakuModule module = KagayakuModule([], 'https://kagayaku.vercel.com');

  NovelDetailsState copyWith({
    KagayakuModule? module,
  }) {
    return NovelDetailsState()..module = module ?? this.module;
  }
}

final novelDetailsProvider =
    StateNotifierProvider.autoDispose<DiscoverStateNotifier, NovelDetailsState>(
  (ref) => DiscoverStateNotifier(NovelDetailsState()),
);

class DiscoverStateNotifier extends StateNotifier<NovelDetailsState> {
  DiscoverStateNotifier(super._state);

  setNovel(String url) {
    print(url);
  }
}
