$domainObj = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
$PDC = ($domainObj.PdcRoleOwner).Name
$SearchString = "LDAP://"
$SearchString += $PDC + "/"
$DistinguishedName = "DC=$($domainObj.Name.Replace('.', ',DC='))"
$SearchString += $DistinguishedName
$SearchString
$Searcher = New-Object System.DirectoryServices.DirectorySearcher([ADSI]$SearchString)
$objDomain = New-Object System.DirectoryServices.DirectoryEntry
$Searcher.SearchRoot = $objDomain
$Searcher.filter="serviceprincipalname=*"
$Result = $Searcher.FindAll()
Foreach($obj in $Result)
{
    #Foreach($prop in $obj.Properties)
    #{
    #    $prop
    #}
    $obj.Properties.name
    Foreach($spn in $obj.Properties.serviceprincipalname)
    {
        $spn
        $a = $spn.substring($spn.LastIndexOf("/") +1)
        $a -replace ":.*",""
        nslookup $a
    }
    Write-Host "------------------------"
}
