#################################################################################################################################################################
# Purpose of this script is to send an email to a bulk list of users using the Outlook Application
# This mimics as if you sent out the email manually
# There could be some formatting issues with HTML messages. Works best with plain text emails.
#################################################################################################################################################################

#####################################################
# Constants
#####################################################

# In my use case I had to attach a file to each email where the file had the recipient's username in the filename. 
# This is path to location of the folder which held the files
$FolderPath = "C:\Folder"


# Path to CSV file
# Format with headers username,email,fname
$EmailPath = "C:\Folder\Emails.csv"
$EmailFile = Import-Csv $EmailPath
 
#####################################################
# SCRIPT BODY
#####################################################

foreach ($Email in $EmailFile) { 
    # Loop through each email and create a new Outlook mail object
    # You obivously need Outlook app installed and signed in for this to work
    $o = New-Object -com Outlook.Application
    $mail = $o.CreateItem(0)
    
    # 2 = High importance message if needed
    # $mail.importance = 2

    # Path to a signature html file. Easiest way is to create a draft email with just the signature and save it as html
    # If your sig has images, you may need to modify the html to source those locally.
    $sig = [IO.File]::ReadAllText("C:\Folder\signature.html")
    
    # Email subject line
    $mail.subject = "Test Email"

    # Email body; you can do some html formatting here. In my testing, complex formating does not work well
    # It may be possible to do something similar as signature file and just pass a draft_email.html to this instead...

    $mail.HTMLBody = "<html style`"=font-family:Calibri;size:12px;`">$($Email.fname),<br>This is a test email!<br><br>Thanks,</html>$($sig) "

    # Separate multiple recipients with a ";"
    $mail.To = $Email.email
    # CC recipients
    $mail.CC = "" 


    # We are searching the folder for the file to attach to this email
    $files = Get-ChildItem $FolderPath
    $search = "*" + $Email.username + "*"
    Write-Host $search

    for ($i = 0; $i -lt $files.Count; $i++) {
 
        $outfilefull = $files[$i].FullName
        $outfileName = $files[$i].BaseName
        #Write-Host $outfileName

        # If the file is the one we want, add to attachments
        if ($outfileName -like $search) {

            Write-Host "Found "$outfileName
            $mail.Attachments.Add($outfilefull);
            $finalfilename = $outfileName
        }
    }


    # Confirmation that everything looks correct before sending
    $Answer = Read-Host "Email being sent to"  $Email.email  "with attachment" $finalfilename ". Please type yes or y to confirm"

    if ($Answer -eq "yes" -or $Answer -eq "y") {
        $mail.Send()
        Write-Host "sending....."
    }
    else {
        continue
    }
 
    # give time to send the email before going to next one
    Start-Sleep 10
}

#####################################################
# CLEAN UP
#####################################################

# Quit Outlook
$o.Quit()
 
# End the script
exit