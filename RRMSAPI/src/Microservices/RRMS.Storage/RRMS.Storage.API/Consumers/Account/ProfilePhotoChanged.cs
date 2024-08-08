using MassTransit;
using MediatR;
using RRMS.Microservices.Transport.Messages.Account.ProfilePhotoChanged;
using RRMS.Storage.Application.Features.Storage.Commands.DeleteCommand;

namespace RRMS.Storage.API.Consumers.Auth;

public class ProfilePhotoChangedConsumer : IConsumer<ProfilePhotoChangedMessage>
{
    public static string Endpoint = "profile-photo-changed";

    private readonly ISender _sender;

    public ProfilePhotoChangedConsumer(ISender sender) => _sender = sender;

    public async Task Consume(ConsumeContext<ProfilePhotoChangedMessage> context)
    {
        var command = new DeleteCommand
        {
            Url = context.Message.OldProfilePhotoUrl,
        };

        await _sender.Send(command);
    }
}
