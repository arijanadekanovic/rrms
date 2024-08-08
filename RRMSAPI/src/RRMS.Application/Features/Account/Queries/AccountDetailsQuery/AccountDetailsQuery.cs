using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features.Account.Queries.AccountDetailsQuery;

public sealed record AccountDetailsQuery() : IQuery<AccountDetailsQueryResult>;
