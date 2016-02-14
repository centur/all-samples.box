cls;
$emailsFile = "$PSScriptRoot/emails.txt";

$hibpServiceURL = "https://haveibeenpwned.com/api/breachedaccount/";

Get-Content -Path $emailsFile |
    %{ 
        $r = $null;
        $email = $_;
        $fullUrl = "$hibpServiceURL$email"
        
        try{
            $r =Invoke-WebRequest -Method:Get -Uri $fullUrl -Header @{ "api-version"= 2} -UserAgent "Centur-powershell-checker" -ContentType "application/json" -TimeoutSec 30 -ErrorAction:Ignore
        }
        catch{

            Write-Host "$email - OK!" -ForegroundColor:Green
            #Failure
        }

        if($r.StatusCode -eq 200)
        {
            Write-Host "$_ - Breach DETECTED! See $fullUrl" -BackgroundColor:Red -ForegroundColor:Yellow
        }

    }