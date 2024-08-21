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
            _HistoryButton(),
            _FiltersButton(),
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

class _HistoryButton extends StatelessWidget {
  const _HistoryButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.history,
        size: 28,
        color: context.appTheme.accentColor,
      ),
      onPressed: () {
        // TODO: PUSH RESIDENCES HISTORY FOR CURRENT USER (WHERE THEY WERE RESIDENT)
      },
    );
  }
}

class _FiltersButton extends StatelessWidget {
  const _FiltersButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.filter_list_sharp,
        size: 28,
        color: context.appTheme.accentColor,
      ),
      onPressed: () => showAppDialog(
        context,
        AppDialogModel(
          scrollable: true,
          title: 'Choose filters:',
          providerBuilder: (child) => BlocProvider.value(
            value: context.read<ResidencesCubit>(),
            child: child,
          ),
          child: BlocBuilder<ResidencesCubit, ResidencesState>(
            builder: (context, residencesState) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _Location(),
                    Gap(10),
                    _PriceFromTo(),
                    Gap(10),
                    _SizeFromTo(),
                    Gap(10),
                    _Rooms(),
                    Gap(10),
                    _Category(),
                    Gap(20),
                    _Actions(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Location extends StatelessWidget {
  const _Location();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResidencesCubit, ResidencesState>(
      builder: (context, residencesState) {
        return CityFormField(
          label: 'Location',
          initialId: residencesState.searchModel.cityId,
          onChanged: (city) => context.read<ResidencesCubit>().updateSearchModel(residencesState.searchModel.copyWith(cityId: city?.id)),
          borderColor: context.appTheme.accentColor,
        );
      },
    );
  }
}

class _PriceFromTo extends StatelessWidget {
  const _PriceFromTo();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResidencesCubit, ResidencesState>(
      builder: (context, residencesState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price', style: context.textStyle.t14500),
            const Gap(10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AppTextField(
                    hint: 'From',
                    borderColor: context.appTheme.accentColor,
                    initialValue: residencesState.searchModel.priceFrom?.toString(),
                    onChanged: (text) {
                      final value = double.tryParse(text.value);

                      if (value != null) {
                        context.read<ResidencesCubit>().updateSearchModel(residencesState.searchModel.copyWith(priceFrom: value));
                      }
                    },
                    margin: EdgeInsets.zero,
                  ),
                ),
                const Gap(5),
                Text('-'),
                const Gap(5),
                Expanded(
                  child: AppTextField(
                    hint: 'To',
                    borderColor: context.appTheme.accentColor,
                    initialValue: residencesState.searchModel.priceTo?.toString(),
                    onChanged: (text) {
                      final value = double.tryParse(text.value);

                      if (value != null) {
                        context.read<ResidencesCubit>().updateSearchModel(residencesState.searchModel.copyWith(priceTo: value));
                      }
                    },
                    margin: EdgeInsets.zero,
                  ),
                ),
                const Gap(5),
                Text('  \$'),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _SizeFromTo extends StatelessWidget {
  const _SizeFromTo();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResidencesCubit, ResidencesState>(
      builder: (context, residencesState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Size', style: context.textStyle.t14500),
            const Gap(10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AppTextField(
                    hint: 'From',
                    borderColor: context.appTheme.accentColor,
                    initialValue: residencesState.searchModel.sizeFrom?.toString(),
                    onChanged: (text) {
                      final value = double.tryParse(text.value);

                      if (value != null) {
                        context.read<ResidencesCubit>().updateSearchModel(residencesState.searchModel.copyWith(sizeFrom: value));
                      }
                    },
                    margin: EdgeInsets.zero,
                  ),
                ),
                const Gap(5),
                Text('-'),
                const Gap(5),
                Expanded(
                  child: AppTextField(
                    hint: 'To',
                    borderColor: context.appTheme.accentColor,
                    initialValue: residencesState.searchModel.sizeTo?.toString(),
                    onChanged: (text) {
                      final value = double.tryParse(text.value);

                      if (value != null) {
                        context.read<ResidencesCubit>().updateSearchModel(residencesState.searchModel.copyWith(sizeTo: value));
                      }
                    },
                    margin: EdgeInsets.zero,
                  ),
                ),
                const Gap(5),
                Text('m2'),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _Rooms extends StatelessWidget {
  const _Rooms();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResidencesCubit, ResidencesState>(
      builder: (context, residencesState) {
        return AppTextField(
          label: 'Rooms',
          hint: 'Number of rooms',
          borderColor: context.appTheme.accentColor,
          margin: EdgeInsets.zero,
          initialValue: residencesState.searchModel.numberOfRooms?.toString(),
          onChanged: (text) {
            final value = int.tryParse(text.value);

            if (value != null) {
              context.read<ResidencesCubit>().updateSearchModel(residencesState.searchModel.copyWith(numberOfRooms: value));
            }
          },
        );
      },
    );
  }
}

class _Category extends StatelessWidget {
  const _Category();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResidencesCubit, ResidencesState>(
      builder: (context, residencesState) {
        return ResidenceTypeFormField(
          label: 'Type',
          initialValue: residencesState.searchModel.type,
          onChanged: (type) => context.read<ResidencesCubit>().updateSearchModel(residencesState.searchModel.copyWith(type: type)),
          borderColor: context.appTheme.accentColor,
        );
      },
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<ResidencesCubit, ResidencesState>(
            builder: (context, residencesState) {
              return Button(
                primary: true,
                text: 'Apply',
                onTap: () {
                  context.read<ResidencesCubit>().load(residencesState.searchModel);
                  context.pop();
                },
              );
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
    );
  }
}
