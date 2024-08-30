import 'package:rrms/_all.dart';

class ChatGroupListTile extends StatelessWidget {
  final void Function()? onTap;
  final ChatGroupResponseModel chatGroup;

  const ChatGroupListTile({
    super.key,
    this.onTap,
    required this.chatGroup,
  });

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: context.appTheme.cardBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImage(
              url: chatGroup.chatPartnerProfilePictureUrl,
              borderRadius: BorderRadius.circular(100),
              height: 60,
              width: 60,
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chatGroup.chatPartnerName.value,
                          style: context.textStyle.t14500,
                        ),
                      ),
                      Text(
                        chatGroup.lastMessageDateTime.formatDateTime(),
                        style: context.textStyle.t12400,
                      ),
                    ],
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chatGroup.lastMessage.value,
                          style: context.secondaryTextStyle.t12500,
                        ),
                      ),
                      if (!chatGroup.seen.value)
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.circle,
                            size: 10,
                            color: context.appTheme.blue,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
