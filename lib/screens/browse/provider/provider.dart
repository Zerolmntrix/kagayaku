import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/methods/source.dart';
import '../../../data/models/module.dart';
import '../../../data/models/source.dart';
import '../../../utils/database.dart';

class BrowseState {
  List<Source> sources = [];
  List<ModuleModel> modules = [];
  int currentPage = 0;
  bool loaded = false;

  BrowseState();

  BrowseState copyWith(
      {List<Source>? sources,
      List<ModuleModel>? modules,
      int? currentPage,
      bool? loaded}) {
    return BrowseState()
      ..sources = sources ?? this.sources
      ..modules = modules ?? this.modules
      ..currentPage = currentPage ?? this.currentPage
      ..loaded = loaded ?? this.loaded;
  }
}

final browseProvider =
    StateNotifierProvider.autoDispose<BrowseStateNotifier, BrowseState>((ref) {
  ref.onDispose(() => closeDB());

  return BrowseStateNotifier(BrowseState());
});

class BrowseStateNotifier extends StateNotifier<BrowseState> {
  BrowseStateNotifier(BrowseState state) : super(state);

  setSources() async {
    final sources = await SourceMethods.readAllSources();

    state = state.copyWith(sources: sources);
  }

  setModules(List<ModuleModel> modules) async {
    final sources = await SourceMethods.readAllSources();

    final availableModules = modules
        .where(
          (module) => !sources.any((source) => source.moduleId == module.id),
        )
        .toList();

    availableModules.sort((a, b) => a.name.compareTo(b.name));

    state = state.copyWith(modules: availableModules, loaded: true);
  }

  addSource(Source source) async {
    await SourceMethods.create(source);
    setSources();
  }

  togglePin(Source source) {
    final updatedSource = source.copy(isPinned: !source.isPinned);
    SourceMethods.update(updatedSource);
    setSources();
  }

  setPage(int index) {
    state = state.copyWith(currentPage: index);
  }
}
