import 'package:rrms/_all.dart';

class ResidencesFilters extends StatelessWidget {
  const ResidencesFilters({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _SearchTextField()),
            IconButton(
              icon: Icon(
                Icons.history,
                size: 28,
                color: context.appTheme.accentColor,
              ),
              onPressed: () {
                // TODO: PUSH RESIDENCES HISTORY FOR CURRENT USER (WHERE THEY WERE RESIDENT)
              },
            ),
            IconButton(
              icon: Icon(
                Icons.filter_list_sharp,
                size: 28,
                color: context.appTheme.accentColor,
              ),
              onPressed: () => showAppDialog(
                context,
                AppDialogModel(
                  title: 'Choose filters:',
                  useCancelIcon: false,
                  providerBuilder: (child) => BlocProvider.value(
                    value: context.read<ResidencesCubit>(),
                    child: child,
                  ),
                  child: BlocBuilder<ResidencesCubit, ResidencesState>(
                    builder: (context, residencesState) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            CityFormField(
                              initialId: residencesState.searchModel.cityId,
                              onChanged: (city) => context.read<ResidencesCubit>().updateSearchModel(residencesState.searchModel.copyWith(cityId: city?.id)),
                              borderColor: context.appTheme.accentColor,
                            ),
                            const Gap(20),
                            Row(
                              children: [
                                Expanded(
                                  child: Button(
                                    primary: true,
                                    text: 'Apply',
                                    onTap: () {
                                      context.read<ResidencesCubit>().load(residencesState.searchModel);
                                      context.pop();
                                    },
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: Button(
                                    secondary: true,
                                    text: 'Clear',
                                    onTap: () {
                                      context.read<ResidencesCubit>().load(ResidencesSearchRequestModel());
                                      context.pop();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SearchTextField extends StatelessWidget {
  const _SearchTextField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResidencesCubit, ResidencesState>(
      builder: (context, residencesState) {
        return AppTextField(
          margin: EdgeInsets.zero,
          initialValue: residencesState.searchModel.searchTerm,
          onChanged: (text) => debouncer.debounce(() => context.read<ResidencesCubit>().load(residencesState.searchModel.copyWith(searchTerm: text))),
          hint: 'Search ...',
          borderRadius: BorderRadius.circular(30),
          borderColor: context.appTheme.accentColor,
          height: 40,
          sufixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.appTheme.accentColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: EdgeInsets.all(3),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
