enum AppPdfViewerStateStatus {
  initializing,
  initialized,
  error,
}

class AppPdfViewerState {
  final AppPdfViewerStateStatus status;
  final AppPdfViewerStateModel model;

  AppPdfViewerState({
    required this.status,
    required this.model,
  });

  factory AppPdfViewerState.initial(String url) => AppPdfViewerState(
        status: AppPdfViewerStateStatus.initializing,
        model: AppPdfViewerStateModel(url: url),
      );

  AppPdfViewerState copyWith({
    AppPdfViewerStateStatus? status,
    AppPdfViewerStateModel? model,
  }) =>
      AppPdfViewerState(
        status: status ?? this.status,
        model: model ?? this.model,
      );
}

class AppPdfViewerStateModel {
  final int currentPage;
  final int totalPages;
  final String? url;

  AppPdfViewerStateModel({
    this.currentPage = 0,
    this.totalPages = 0,
    this.url,
  });

  AppPdfViewerStateModel copyWith({
    int? currentPage,
    int? totalPages,
    String? url,
  }) {
    return AppPdfViewerStateModel(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      url: url ?? this.url,
    );
  }
}
