import 'package:rrms/_all.dart';

class AppFormField extends StatelessWidget {
  final String? title;
  final Widget? child;

  const AppFormField({
    super.key,
    this.title,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotNullOrEmpty) ...{
          Text(title.value, style: context.textStyle.t14500),
          const Gap(10),
        },
        if (child != null) child!,
      ],
    );
  }
}
