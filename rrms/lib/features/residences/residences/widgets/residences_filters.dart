import 'package:rrms/_all.dart';

class ResidencesFilters extends StatelessWidget {
  const ResidencesFilters({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SearchTextField(),
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
