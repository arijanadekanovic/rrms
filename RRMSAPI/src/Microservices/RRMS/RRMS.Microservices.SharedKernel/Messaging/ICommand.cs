using MediatR;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Microservices.SharedKernel.Messaging;

public interface ICommand : IRequest<Result>
{
}

public interface ICommand<TResponse> : IRequest<Result<TResponse>>
{
}
