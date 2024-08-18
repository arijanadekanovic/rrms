﻿using RRMS.Microservices.SharedKernel.Messaging;

namespace RRMS.Application.Features.Payment.Queries.PaymentsQuery
{
    public sealed record PaymentsQuery() : IQuery<List<PaymentQueryResult>>
    {
        public DateTime? FromDateUtc { get; init; }
        public DateTime? ToDateUtc { get; init; }
    }
}