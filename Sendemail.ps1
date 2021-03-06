Param( [String]$Att,
        [String]$Subj,
        [String]$Body)
        
Function Send-EMail
{
    Param( 
            [Parameter(`
            Mandatory= $true)]
        [String]$To,
            [Parameter(`
            Mandatory= $true)]
        [String]$From,
            [Parameter(`
            Mandatory= $true)]
        [String]$Password,
            [Parameter(`
            Mandatory=$true)]
        [String]$Subject,
            [Parameter(`
            Mandatory=$true)]
        [String]$Body,
            [Parameter(`
            Mandatory=$true)]
        [String]$attachment
        )
    
try
{
    $Msg = New-Object System.Net.Mail.MailMessange($From, $To, $Subject, $Boby)
    #Learning about smtp server: Simple Mail Transfer Protocol
    #Need  Gmail SMTP server settins if I want to send email frommy Gmail account to through an email software prog
    $Srv = "smtp.gmail.com"
    if ($attachment -ne $null)    #check your attachment status
    {
        try
        {
            $Attachments = $attachment -split ("\:\:");     #Put a string that split 
            
            ForEach($val in $Attachments)      #iterator: val in Attachments
            {
                $attch = New-Object System.Net.Mail.Attachment($val)    #add attach with each char of val
                $Msg.Attachments.Add($attch)   #MSG to attachment 
            }
        }
        catch
        {
            exit 2;
        }

        $Client = New-Object Net.Mail.Smtpclient($Srv, 587)
        $Client.EnableSsl = $true
        $Client.Credentials = New-Object System.Net.NetworkCredential($From.Split("@")[0], $Password)
        $Client.Send($Msg)
        Remove-Variable -Name Client
        Remove-Variable -Name Password
        exit 7;     #type of error

    }
}

catch
    {
        exit 3;     #type of error
    }
}

try
{
    Send-EMail
        -attachment $Att
        -To "Address of the recipient"
        -Body $Body
        -Subject $Subj
        -password "123123"
        -From "Address of the sender"
}
catch
{
    exit 4;    #type of error, SHOULD LOOK UP ON INTERNET
}