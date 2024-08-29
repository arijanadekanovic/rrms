import 'package:rrms/_all.dart';

class RentRequestTile extends StatelessWidget {
  const RentRequestTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose your rental dates:',
            style: context.textStyle.t16500,
          ),
          const Gap(20),
          Row(
            children: [
              Expanded(
                child: AppDateFormField(
                  label: 'Start date',
                  borderColor: context.secondaryTextStyle.color,
                ),
              ),
              const Gap(15),
              Expanded(
                child: AppDateFormField(
                  label: 'End date',
                  borderColor: context.secondaryTextStyle.color,
                ),
              ),
            ],
          ),
          const Gap(40),
          Row(
            children: [
              Expanded(
                child: Button(
                  text: 'Send request',
                  textStyle: context.textStyle.t16600,
                  primary: true,
                  padding: EdgeInsets.all(6),
                  onTap: () {
                    // Implement send request
                  },
                ),
              ),
              const Gap(15),
              Expanded(
                child: Button(
                  text: 'Cancel',
                  textStyle: context.textStyle.t16600,
                  secondary: true,
                  padding: EdgeInsets.all(6),
                  onTap: () => context.pop(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
