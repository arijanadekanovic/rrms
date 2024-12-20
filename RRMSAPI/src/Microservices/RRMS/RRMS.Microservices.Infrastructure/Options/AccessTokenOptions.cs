﻿namespace RRMS.Microservices.Infrastructure.Options;

public class AccessTokenOptions
{
    public string SecurityKey { get; init; }
    public long DurationInSeconds { get; init; }
    public string Issuer { get; init; }
    public string Audience { get; init; }
}
