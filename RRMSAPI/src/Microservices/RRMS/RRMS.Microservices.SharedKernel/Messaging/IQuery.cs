using MediatR;
using RRMS.Microservices.SharedKernel.Primitives;

namespace RRMS.Microservices.SharedKernel.Messaging;

public interface IQuery<TResponse> : IRequest<Result<TResponse>>
{
}
