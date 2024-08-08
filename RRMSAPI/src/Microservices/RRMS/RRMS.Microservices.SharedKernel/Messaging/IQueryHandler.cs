using MediatR;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Microservices.SharedKernel.Messaging;

public interface IQueryHandler<TQuery, TResponse>
    : IRequestHandler<TQuery, Result<TResponse>>
    where TQuery : IQuery<TResponse>
{
}
