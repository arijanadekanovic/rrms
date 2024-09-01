import 'package:rrms/_all.dart';

class ChatMessageTile extends StatelessWidget {
  final ChatMessageResponseModel chatMessage;

  const ChatMessageTile({
    super.key,
    required this.chatMessage,
  });

  @override
  Widget build(BuildContext context) {
    final image = CachedImage(
      url: chatMessage.profilePhotoUrl,
      height: 50,
      width: 50,
      borderRadius: BorderRadius.circular(50),
    );

    return Row(
      mainAxisAlignment: chatMessage.isMyMessage.value ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!chatMessage.isMyMessage.value) image,
        const Gap(10),
        Column(
          crossAxisAlignment: chatMessage.isMyMessage.value ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              chatMessage.messageDateTimeUtc.formatDateTime(),
              style: context.secondaryTextStyle.t10500,
            ),
            const Gap(5),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.2,
                  color: chatMessage.isMyMessage.value ? context.appTheme.accentColor : context.appTheme.blue,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              child: Text(chatMessage.message ?? ''),
            ),
          ],
        ),
        const Gap(10),
        if (chatMessage.isMyMessage.value) image,
      ],
    );
  }
}
