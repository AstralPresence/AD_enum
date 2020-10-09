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
$Searcher.filter="(objectClass=computer)"
#$Searcher.filter="(name=Domain admins)"
$Result = $Searcher.FindAll()
$Result
Foreach($obj in $Result)
{
    #Foreach($prop in $obj)
    #{
    #    $prop
    #}
    $obj.Properties.name
    Write-Host "------------------------"
}
