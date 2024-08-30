import 'package:rrms/_all.dart';

class ResidenceDetailsContent extends StatelessWidget {
  final ResidenceResponseModel residence;
  final bool allowActions;

  const ResidenceDetailsContent({
    super.key,
    required this.residence,
    this.allowActions = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: BlocProvider(
        create: (context) => services.get<ResidenceDetailsCubit>()..load(residence.id.value),
        child: BlocBuilder<ResidenceDetailsCubit, ResidenceDetailsState>(
          builder: (context, residenceDetailsState) {
            if (residenceDetailsState.status == ResidenceDetailsStateStatus.loading) {
              return Loader();
            }

            if (residenceDetailsState.details == null) {
              return Center(child: Text('No data'));
            }

            final details = residenceDetailsState.details!;

            return ListView(
              padding: EdgeInsets.symmetric(vertical: 15),
              children: [
                CachedImage(
                  url: details.thumbnailUrl,
                ),
                const Gap(20),
                _DetailsItemListTile(
                  title: 'Name',
                  text: details.name,
                ),
                _DetailsItemListTile(
                  title: 'Location',
                  text: '${details.city?.name}, ${details.address}',
                ),
                _DetailsItemListTile(
                  title: 'Rooms',
                  text: '${details.rooms} ${details.rooms.spValue('room', 'rooms')}',
                ),
                _DetailsItemListTile(
                  title: 'Rooms',
                  text: '${details.size.formatDecimals()} m2',
                ),
                _DetailsItemListTile(
                  title: 'Rent',
                  text: details.rentPrice.formatPriceWithCurrency(),
                ),
                _DetailsItemListTile(
                  title: 'Type',
                  text: details.type?.title,
                ),
                const Gap(10),
                Text('Description:', style: context.textStyle.t14500),
                const Gap(10),
                Text(details.description.value, style: context.textStyle.t14500),
                if (allowActions)
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, profileState) {
                      if (!profileState.isResident) {
                        return const SizedBox();
                      }

                      return Column(
                        children: [
                          const Gap(40),
                          Row(
                            children: [
                              Expanded(
                                child: Button(
                                  textStyle: context.textStyle.t16600,
                                  padding: EdgeInsets.all(10),
                                  primary: true,
                                  text: 'Message',
                                  onTap: () {},
                                ),
                              ),
                              const Gap(30),
                              Expanded(
                                child: Button(
                                  textStyle: context.textStyle.t16600,
                                  padding: EdgeInsets.all(10),
                                  primary: true,
                                  color: context.appTheme.blue,
                                  text: 'Rent',
                                  onTap: () {
                                    showAppDialog(
                                      context,
                                      AppDialogModel(
                                        title: 'Rent request',
                                        child: ResidentAddForm(
                                          residenceId: details.id.value,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DetailsItemListTile extends StatelessWidget {
  final String title;
  final String? text;

  const _DetailsItemListTile({
    required this.title,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '$title:',
              style: context.textStyle.t14500,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              text.value,
              style: context.textStyle.t14500,
            ),
          ),
        ],
      ),
    );
  }
}