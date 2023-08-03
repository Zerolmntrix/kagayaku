import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../data/source_data.dart';
import '../../../shared/constants/endpoints.dart';

class DiscoverState {
  DiscoverState();

  bool isLoading = true;

  // FIXME: This is a temporary solution to avoid breaking the app

  //! LateInitializationError: Field 'sourceData' has not been initialized.
  late SourceData sourceData;

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

  setSourceData() async {
    final response = await http.get(Uri.parse(Endpoints.test));

    final kayaContent = response.body.split('\n').map((e) => e.trim()).toList();

    state = state.copyWith(sourceData: SourceData(kayaContent));
  }

  setLoaded() {
    state = state.copyWith(isLoading: false);
  }

  setUnloaded() {
    state = state.copyWith(isLoading: true);
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

  List<NovelModel> getNovels(String list) {
    switch (list) {
      case 'popular':
        return state.popularNovels;
      case 'latest':
        return state.latestNovels;
      default:
        return [];
    }
  }
}
