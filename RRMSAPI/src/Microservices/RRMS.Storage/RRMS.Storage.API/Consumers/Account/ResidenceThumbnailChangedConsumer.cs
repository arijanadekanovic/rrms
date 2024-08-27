using MassTransit;
using MediatR;
using RRMS.Microservices.Transport.Messages.Account.ProfilePhotoChanged;
using RRMS.Storage.Application.Features.Storage.Commands.DeleteCommand;

namespace RRMS.Storage.API.Consumers;

public class ResidenceThumbnailChangedConsumer : IConsumer<ResidenceThumbnailChangedMessage>
{
    public static string Endpoint = "residence-thumbnail-changed";

    private readonly ISender _sender;

    public ResidenceThumbnailChangedConsumer(ISender sender) => _sender = sender;

    public async Task Consume(ConsumeContext<ResidenceThumbnailChangedMessage> context)
    {
        var command = new DeleteCommand
        {
            Url = context.Message.OldUrl,
        };

        await _sender.Send(command);
    }
}
