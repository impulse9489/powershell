# Backup Outlook pst.

$outlookPSTLocation =  @("C:\Users\skarp\Documents\Outlook Files\archive.pst")
$outlookPSTBackupLocation = "E:\Dropbox\outlook\"

$outlookEXE = Get-ItemProperty "hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\OUTLOOK.EXE"
$outlookEXE = $outlookEXE."(default)"



Function StopOutLook()
{
	$outlook = $false
	try
	{
		$outlook = Get-Process "Outlook"
	}
	catch
	{
		Write-Host "could not find outlook"
		$outlook = $false
	}
	Write-Host $outlook
	while ( $outlook)
	{
		
		$outlook |   Foreach-Object { $_.CloseMainWindow() | Out-Null } | stop-process –force
		try 
		{
			$outlook = Get-Process "Outlook"
		}
		catch
		{
			$outlook = $false
		}
	}

	Sleep 5

}


StopOutLook

foreach ($item in $outlookPSTLocation)
{
	Copy-Item $item $outlookPSTBackupLocation
	Write-Host "copied file: $item"
}

Start-Process $outlookEXE