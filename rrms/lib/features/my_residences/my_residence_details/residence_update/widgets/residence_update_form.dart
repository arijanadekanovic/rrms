import 'package:rrms/_all.dart';

class ResidenceUpdateForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final int id;

  ResidenceUpdateForm({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => services.get<ResidenceUpdateCubit>()..init(id),
      child: BlocConsumer<ResidenceUpdateCubit, ResidenceUpdateState>(
        listener: (context, residenceUpdateState) {
          if (residenceUpdateState.status == ResidenceUpdateStateStatus.submittingSuccess) {
            toast.success('You have successfully updated a residence!');
            context.pop();
          }

          if (residenceUpdateState.status == ResidenceUpdateStateStatus.validationError) {
            _formKey.validate();
          }
        },
        builder: (context, residenceUpdateState) {
          if (residenceUpdateState.status == ResidenceUpdateStateStatus.initializing) {
            return Loader();
          }

          return Form(
            key: _formKey,
            autovalidateMode: residenceUpdateState.autovalidateMode,
            child: Column(
              children: [
                AppImageFormField(
                  initialValueFile: residenceUpdateState.model.thumbnail?.file,
                  initialValueUrl: residenceUpdateState.model.thumbnailUrl,
                  useCropper: true,
                  width: context.screenWidth,
                  height: (context.screenWidth / (16 / 9)) - 40,
                  placeholder: Icon(Icons.image, color: context.secondaryTextStyle.color, size: 50),
                  cropAspectRatio: MediaPickerButtonCropAspectRatio.ratio16x9(),
                  onChanged: (file) => context.read<ResidenceUpdateCubit>().update(residenceUpdateState.model.copyWith(thumbnail: Optional(file))),
                  onClear: () => context.read<ResidenceUpdateCubit>().update(
                        residenceUpdateState.model.copyWith(
                          thumbnail: Optional.absent(),
                          thumbnailUrl: Optional.absent(),
                        ),
                      ),
                ),
                const Gap(10),
                AppTextFormField(
                  label: 'Name',
                  initialValue: residenceUpdateState.model.name,
                  onChanged: (text) => context.read<ResidenceUpdateCubit>().update(residenceUpdateState.model.copyWith(name: text)),
                  validator: (text) => residenceUpdateState.modelValidator.name(residenceUpdateState.model.copyWith(name: text)),
                ),
                const Gap(10),
                AppTextFormField(
                  label: 'Number of rooms',
                  initialValue: residenceUpdateState.model.rooms?.toString(),
                  textInputType: TextInputType.numberWithOptions(signed: false, decimal: false),
                  onChanged: (text) => context.read<ResidenceUpdateCubit>().update(residenceUpdateState.model.copyWith(rooms: int.tryParse(text.value))),
                  validator: (text) => residenceUpdateState.modelValidator.rooms(residenceUpdateState.model.copyWith(rooms: int.tryParse(text.value))),
                ),
                const Gap(10),
                AppTextFormField(
                  label: 'Square footage',
                  initialValue: residenceUpdateState.model.size?.formatDecimals(),
                  textInputType: TextInputType.numberWithOptions(decimal: true),
                  onChanged: (text) => context.read<ResidenceUpdateCubit>().update(residenceUpdateState.model.copyWith(size: double.tryParse(text.value))),
                  validator: (text) => residenceUpdateState.modelValidator.size(residenceUpdateState.model.copyWith(size: double.tryParse(text.value))),
                ),
                const Gap(10),
                AppTextFormField(
                  label: 'Rent price',
                  initialValue: residenceUpdateState.model.rentPrice?.formatDecimals(),
                  textInputType: TextInputType.numberWithOptions(decimal: true),
                  onChanged: (text) => context.read<ResidenceUpdateCubit>().update(residenceUpdateState.model.copyWith(rentPrice: double.tryParse(text.value))),
                  validator: (text) => residenceUpdateState.modelValidator.rentPrice(residenceUpdateState.model.copyWith(rentPrice: double.tryParse(text.value))),
                ),
                const Gap(10),
                ResidenceTypeFormField(
                  hint: 'Type',
                  initialValue: residenceUpdateState.model.type,
                  onChanged: (type) => context.read<ResidenceUpdateCubit>().update(residenceUpdateState.model.copyWith(type: type)),
                  validator: (type) => residenceUpdateState.modelValidator.type(residenceUpdateState.model.copyWith(type: type)),
                ),
                const Gap(10),
                CityFormField(
                  hint: 'Location',
                  initialId: residenceUpdateState.model.cityId,
                  onChanged: (city) => context.read<ResidenceUpdateCubit>().update(residenceUpdateState.model.copyWith(cityId: city?.id)),
                  validator: (city) => residenceUpdateState.modelValidator.cityId(residenceUpdateState.model.copyWith(cityId: city?.id)),
                ),
                const Gap(10),
                AppTextFormField(
                  label: 'Address',
                  initialValue: residenceUpdateState.model.address,
                  onChanged: (text) => context.read<ResidenceUpdateCubit>().update(residenceUpdateState.model.copyWith(address: text)),
                  validator: (text) => residenceUpdateState.modelValidator.address(residenceUpdateState.model.copyWith(address: text)),
                ),
                const Gap(10),
                const Gap(10),
                AppTextFormField(
                  label: 'Description',
                  initialValue: residenceUpdateState.model.description,
                  minLines: 5,
                  maxLines: 10,
                  onChanged: (text) => context.read<ResidenceUpdateCubit>().update(residenceUpdateState.model.copyWith(description: text)),
                ),
                const Gap(30),
                Button(
                  text: 'Save',
                  onTap: () => context.read<ResidenceUpdateCubit>().submit(),
                  primary: true,
                  isLoading: residenceUpdateState.status == ResidenceUpdateStateStatus.submitting,
                ),
                const Gap(10),
                Button(
                  text: 'Cancel',
                  onTap: () => context.pop(),
                  secondary: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
