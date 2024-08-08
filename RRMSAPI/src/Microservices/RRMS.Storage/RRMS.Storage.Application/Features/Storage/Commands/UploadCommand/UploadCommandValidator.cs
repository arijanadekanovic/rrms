using FluentValidation;

namespace RRMS.Storage.Application.Features.Storage.Commands.UploadCommand;

public class UploadCommandValidator : AbstractValidator<UploadCommand>
{
    public UploadCommandValidator()
    {
        RuleFor(x => x.File).NotNull().NotEmpty();
    }
}
