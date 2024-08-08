using MassTransit;
using MediatR;
using RRMS.Microservices.Transport.Messages.Account.AccountDelete;
using RRMS.Storage.Application.Features.Storage.Commands.DeleteCommand;

namespace RRMS.Storage.API.Consumers.Auth;

public class AccountDeletedConsumer : IConsumer<AccountDeletedMessage>
{
    public static string Endpoint = "account-deleted";

    private readonly ISender _sender;

    public AccountDeletedConsumer(ISender sender) => _sender = sender;

    public async Task Consume(ConsumeContext<AccountDeletedMessage> context)
    {
        var command = new DeleteCommand
        {
            Url = context.Message.ProfilePhotoUrl,
        };

        await _sender.Send(command);
    }
}
