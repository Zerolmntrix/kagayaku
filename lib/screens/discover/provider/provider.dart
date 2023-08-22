import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kagayaku_modules/kagayaku_modules.dart' hide getSourceFromFile;

import '../../../utils/get_module.dart';

class DiscoverState {
  DiscoverState();

  bool isLoading = true;

  KagayakuModule module = KagayakuModule([], 'https://kagayaku.vercel.com');

  List<NovelModel> spotlightNovels = [];
  List<NovelModel> popularNovels = [];
  List<NovelModel> latestNovels = [];

  DiscoverState copyWith({
    bool? isLoading,
    KagayakuModule? module,
    List<NovelModel>? spotlightNovels,
    List<NovelModel>? popularNovels,
    List<NovelModel>? latestNovels,
  }) {
    return DiscoverState()
      ..isLoading = isLoading ?? this.isLoading
      ..module = module ?? this.module
      ..spotlightNovels = spotlightNovels ?? this.spotlightNovels
      ..latestNovels = latestNovels ?? this.latestNovels
      ..popularNovels = popularNovels ?? this.popularNovels;
  }
}

final discoverProvider =
    StateNotifierProvider.autoDispose<DiscoverStateNotifier, DiscoverState>(
  (ref) => DiscoverStateNotifier(DiscoverState()),
);

class DiscoverStateNotifier extends StateNotifier<DiscoverState> {
  DiscoverStateNotifier(super._state);

  setLoaded() {
    state = state.copyWith(isLoading: false);
  }

  setUnloaded() {
    state = state.copyWith(isLoading: true);
  }

  setSource({List<String>? source}) async {
    final source = await getSourceFromFile();
    if (state.module == KagayakuModule(source, 'https://asuralightnovel.com')) {
      return;
    }
    state = state.copyWith(
      module: KagayakuModule(source, 'https://asuralightnovel.com'),
    );
  }

  setSpotlightNovels() async {
    final novels = await state.module.getSpotlightNovels();
    state = state.copyWith(spotlightNovels: novels);
  }

  setPopularNovels() async {
    final novels = await state.module.getPopularNovels();
    state = state.copyWith(popularNovels: novels);
  }

  setLatestNovels() async {
    final novels = await state.module.getLatestNovels();
    state = state.copyWith(latestNovels: novels);
  }
}
