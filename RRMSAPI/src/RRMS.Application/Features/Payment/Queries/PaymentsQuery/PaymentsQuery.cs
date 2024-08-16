using RRMS.Application.Features.Residence.Queries.ResidencesQuery;
using RRMS.Domain.Entities;
using RRMS.Microservices.SharedKernel.Messaging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RRMS.Application.Features.Payment.Queries.PaymentsQuery
{
    public sealed record PaymentsQuery() : IQuery<List<PaymentsQueryResult>>
    {
        public int? ResidentId { get; init; }
        public DateTime? FromDate { get; init; }
        public DateTime? ToDate { get; init; }
    }
}
