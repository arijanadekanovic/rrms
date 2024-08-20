import 'package:rrms/_all.dart';

class CityFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final int? initialId;
  final void Function(CityResponseModel? city)? onChanged;
  final String? Function(CityResponseModel? city)? validator;
  final AutovalidateMode autovalidateMode;
  final Color? color;
  final Color? borderColor;

  const CityFormField({
    super.key,
    this.label,
    this.hint,
    this.initialId,
    this.onChanged,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.color,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitiesCubit, CitiesState>(
      builder: (context, citiesState) {
        final selectedCity = citiesState.cities.firstOrDefault((x) => x.id == initialId);

        return AppDropdownButton(
          label: label,
          hint: hint ?? 'Select city',
          title: selectedCity?.name,
          color: color,
          borderColor: borderColor,
          onTap: () {
            showAppDialog(
              context,
              AppDialogModel(
                title: 'Cities',
                child: BlocBuilder<CitiesCubit, CitiesState>(
                  builder: (context, citiesState) {
                    if (citiesState.status == CitiesStateStatus.loading) {
                      return Loader();
                    }

                    if (citiesState.cities.isNullOrEmpty) {
                      return Center(child: Text('No cities'));
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: citiesState.cities.count,
                      itemBuilder: (context, index) => AppListTile(
                        title: citiesState.cities[index].name ?? '',
                        onTap: () {
                          onChanged?.call(citiesState.cities[index]);
                          context.pop();
                        },
                      ),
                      separatorBuilder: (context, index) => Line.horizontal(),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
