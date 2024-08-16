using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RRMS.Application.Features.Payment.Queries.PaymentsQuery
{
    public sealed record PaymentsQueryResult
    {
        public double Amount { get; init; }
        public string ResidenceName { get; init; }
        public string ResidentName { get; init; }
        public DateTime PaymentDate { get; init; }
    }
}
