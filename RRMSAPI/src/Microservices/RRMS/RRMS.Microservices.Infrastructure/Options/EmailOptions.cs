namespace RRMS.Microservices.Infrastructure.Options;

public class EmailOptions
{
    public string MailServer { get; set; }
    public int MailPort { get; set; }
    public string SenderName { get; set; }
    public string SenderEmail { get; set; }
    public string SenderEmailPassword { get; set; }
}
