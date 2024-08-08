import 'package:rrms/_all.dart';

class AppPdfViewer extends StatelessWidget {
  static const String route = '/pdf-view';

  final AppPdfViewerModel model;

  const AppPdfViewer({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => services.get<AppPdfViewerCubit>(param1: model.url.value),
      child: StatefulBuilder(builder: (context, _) {
        return BlocBuilder<AppPdfViewerCubit, AppPdfViewerState>(
          builder: (context, appPdfViewerState) {
            if (appPdfViewerState.status == AppPdfViewerStateStatus.initializing) {
              return const Loader();
            }

            if (appPdfViewerState.status == AppPdfViewerStateStatus.error) {
              return Text(translations.an_error_occured_please_try_again);
            }

            void updatePageCounts(int? currentPage, int? totalPages) => context.read<AppPdfViewerCubit>().update(
                  appPdfViewerState.model.copyWith(
                    currentPage: currentPage,
                    totalPages: totalPages,
                  ),
                );

            return Scaffold(
              body: Column(
                children: [
                  const _Header(),
                  Expanded(
                    child: PDF(
                      enableSwipe: true,
                      swipeHorizontal: true,
                      autoSpacing: false,
                      pageFling: true,
                      fitPolicy: FitPolicy.WIDTH,
                      pageSnap: true,
                      onViewCreated: (controller) async {
                        final results = await Future.wait([
                          controller.getCurrentPage(),
                          controller.getPageCount(),
                        ]);

                        updatePageCounts(results.first.value + 1, results[1]);
                      },
                      onPageChanged: (page, total) {
                        updatePageCounts(page.value + 1, total);

                        model.onPageChanged?.call(page.value + 1, total.value);
                      },
                    ).cachedFromUrl(appPdfViewerState.model.url.value),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppPdfViewerCubit, AppPdfViewerState>(
      builder: (context, appPdfViewerState) {
        return RRMSAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  color: context.appTheme.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      appPdfViewerState.model.currentPage.toString(),
                      style: context.textStyle.t12400,
                    ),
                    Text('/', style: context.textStyle.t12400),
                    Text(
                      appPdfViewerState.model.totalPages.toString(),
                      style: context.textStyle.t12400,
                    ),
                  ],
                ),
              ),
              const Gap(45),
            ],
          ),
        );
      },
    );
  }
}

class AppPdfViewerModel {
  final String url;
  final void Function(int currentPage, int totalPages)? onInitialized;
  final void Function(int currentPage, int totalPages)? onPageChanged;
  final void Function(int currentPage, int totalPages)? onFinished;

  AppPdfViewerModel({
    required this.url,
    this.onInitialized,
    this.onPageChanged,
    this.onFinished,
  });
}
