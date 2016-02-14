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


#Foreach($Uri in $URLList) {
#  $error.Clear()
#
#  $time = Measure-Command { $request = Invoke-WebRequest -Uri $uri } 2>$null
#
#  if ($error.Count -eq 0) {
#    $time.TotalMilliseconds
#  } else {
#    $error[0].Exception.Response
#    break
#  }
#}

#try {$r = Invoke-WebRequest -Uri "$uri/api/4.0/edges" -Body $body -Method:Post -Headers $head -ContentType "application/xml" -TimeoutSec 180 -ErrorAction:Stop} catch {Failure}


function Failure {
    $global:helpme = $body
    $global:helpmoref = $moref
    $global:result = $_.Exception.Response.GetResponseStream()
    $global:reader = New-Object System.IO.StreamReader($global:result)
    $global:responseBody = $global:reader.ReadToEnd();
    Write-Host -BackgroundColor:Black -ForegroundColor:Red "Status: A system exception was caught."
    Write-Host -BackgroundColor:Black -ForegroundColor:Red $global:responsebody
    Write-Host -BackgroundColor:Black -ForegroundColor:Red "The request body has been saved to `$global:helpme"
}


