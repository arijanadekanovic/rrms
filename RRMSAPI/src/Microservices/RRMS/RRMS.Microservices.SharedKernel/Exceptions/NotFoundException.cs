namespace RRMS.Microservices.SharedKernel.Exceptions;

public sealed class NotFoundException : Exception
{
    public Guid Id { get; set; }

    public NotFoundException(string message, Guid id) : base(message)
    {
        Id = id;
    }

    public NotFoundException()
    {
    }

    public NotFoundException(Guid id)
    {
        Id = id;
    }
}
