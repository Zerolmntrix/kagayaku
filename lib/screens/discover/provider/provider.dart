import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/source_data.dart';
import '../../../utils/get_module.dart';

class DiscoverState {
  DiscoverState();

  bool isLoading = true;

  SourceData sourceData = SourceData([]);

  List<NovelModel> spotlightNovels = [];
  List<NovelModel> popularNovels = [];
  List<NovelModel> latestNovels = [];

  DiscoverState copyWith({
    bool? isLoading,
    SourceData? sourceData,
    List<NovelModel>? spotlightNovels,
    List<NovelModel>? popularNovels,
    List<NovelModel>? latestNovels,
  }) {
    return DiscoverState()
      ..isLoading = isLoading ?? this.isLoading
      ..sourceData = sourceData ?? this.sourceData
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

  setSourceData({List<String>? source}) async {
    final source = await getModuleFromFile();
    if (state.sourceData == SourceData(source)) return;
    state = state.copyWith(sourceData: SourceData(source));
  }

  setSpotlightNovels() async {
    final novels = await state.sourceData.getSpotlightNovels();
    state = state.copyWith(spotlightNovels: novels);
  }

  setPopularNovels() async {
    final novels = await state.sourceData.getPopularNovels();
    state = state.copyWith(popularNovels: novels);
  }

  setLatestNovels() async {
    final novels = await state.sourceData.getLatestNovels();
    state = state.copyWith(latestNovels: novels);
  }
}
