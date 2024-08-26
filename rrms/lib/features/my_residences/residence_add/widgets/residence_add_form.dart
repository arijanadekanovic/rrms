import 'package:rrms/_all.dart';

class ResidenceAddForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ResidenceAddForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => services.get<ResidenceAddCubit>(),
      child: BlocConsumer<ResidenceAddCubit, ResidenceAddState>(
        listener: (context, residenceAddState) {
          if (residenceAddState.status == ResidenceAddStateStatus.submittingSuccess) {
            toast.success('You have successfully added a residence!');
            context.popToBottom();
          }

          if (residenceAddState.status == ResidenceAddStateStatus.validationError) {
            _formKey.validate();
          }
        },
        builder: (context, residenceAddState) {
          return Form(
            key: _formKey,
            autovalidateMode: residenceAddState.autovalidateMode,
            child: Column(
              children: [
                AppImageFormField(
                  initialValueFile: residenceAddState.model.thumbnail?.file,
                  initialValueUrl: residenceAddState.model.thumbnailUrl,
                  useCropper: true,
                  width: context.screenWidth,
                  height: (context.screenWidth / (16 / 9)) - 40,
                  placeholder: Icon(Icons.image, color: context.secondaryTextStyle.color, size: 50),
                  cropAspectRatio: MediaPickerButtonCropAspectRatio.ratio16x9(),
                  onChanged: (file) => context.read<ResidenceAddCubit>().update(residenceAddState.model.copyWith(thumbnail: Optional(file))),
                  onClear: () => context.read<ResidenceAddCubit>().update(
                        residenceAddState.model.copyWith(
                          thumbnail: Optional.absent(),
                          thumbnailUrl: Optional.absent(),
                        ),
                      ),
                ),
                const Gap(10),
                AppTextFormField(
                  label: 'Name',
                  onChanged: (text) => context.read<ResidenceAddCubit>().update(residenceAddState.model.copyWith(name: text)),
                  validator: (text) => residenceAddState.modelValidator.name(residenceAddState.model.copyWith(name: text)),
                ),
                const Gap(10),
                AppTextFormField(
                  label: 'Number of rooms',
                  textInputType: TextInputType.numberWithOptions(signed: false, decimal: false),
                  onChanged: (text) => context.read<ResidenceAddCubit>().update(residenceAddState.model.copyWith(rooms: int.tryParse(text.value))),
                  validator: (text) => residenceAddState.modelValidator.rooms(residenceAddState.model.copyWith(rooms: int.tryParse(text.value))),
                ),
                const Gap(10),
                AppTextFormField(
                  label: 'Square footage',
                  textInputType: TextInputType.numberWithOptions(decimal: true),
                  onChanged: (text) => context.read<ResidenceAddCubit>().update(residenceAddState.model.copyWith(size: double.tryParse(text.value))),
                  validator: (text) => residenceAddState.modelValidator.size(residenceAddState.model.copyWith(size: double.tryParse(text.value))),
                ),
                const Gap(10),
                AppTextFormField(
                  label: 'Rent price',
                  textInputType: TextInputType.numberWithOptions(decimal: true),
                  onChanged: (text) => context.read<ResidenceAddCubit>().update(residenceAddState.model.copyWith(rentPrice: double.tryParse(text.value))),
                  validator: (text) => residenceAddState.modelValidator.rentPrice(residenceAddState.model.copyWith(rentPrice: double.tryParse(text.value))),
                ),
                const Gap(10),
                ResidenceTypeFormField(
                  hint: 'Type',
                  initialValue: residenceAddState.model.type,
                  onChanged: (type) => context.read<ResidenceAddCubit>().update(residenceAddState.model.copyWith(type: type)),
                  validator: (type) => residenceAddState.modelValidator.type(residenceAddState.model.copyWith(type: type)),
                ),
                const Gap(10),
                CityFormField(
                  hint: 'Location',
                  initialId: residenceAddState.model.cityId,
                  onChanged: (city) => context.read<ResidenceAddCubit>().update(residenceAddState.model.copyWith(cityId: city?.id)),
                  validator: (city) => residenceAddState.modelValidator.cityId(residenceAddState.model.copyWith(cityId: city?.id)),
                ),
                const Gap(10),
                AppTextFormField(
                  label: 'Address',
                  onChanged: (text) => context.read<ResidenceAddCubit>().update(residenceAddState.model.copyWith(address: text)),
                  validator: (text) => residenceAddState.modelValidator.address(residenceAddState.model.copyWith(address: text)),
                ),
                const Gap(10),
                const Gap(10),
                AppTextFormField(
                  label: 'Description',
                  minLines: 5,
                  maxLines: 10,
                  onChanged: (text) => context.read<ResidenceAddCubit>().update(residenceAddState.model.copyWith(description: text)),
                ),
                const Gap(30),
                Button(
                  text: 'Save',
                  onTap: () => context.read<ResidenceAddCubit>().submit(),
                  primary: true,
                  isLoading: residenceAddState.status == ResidenceAddStateStatus.submitting,
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
