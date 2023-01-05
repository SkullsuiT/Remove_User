##[Ps1 To Exe]
##
##Kd3HDZOFADWE8uO1
##Nc3NCtDXTlaDjofG5iZk2UHqQyU4Z8mNuOWb4I6r8ebjuiHKdZ4RRVFjk2f1B0Td
##Kd3HFJGZHWLWoLaVvnQnhQ==
##LM/RF4eFHHGZ7/K1
##K8rLFtDXTiW5
##OsHQCZGeTiiZ4NI=
##OcrLFtDXTiW5
##LM/BD5WYTiiZ4tI=
##McvWDJ+OTiiZ4tI=
##OMvOC56PFnzN8u+Vs1Q=
##M9jHFoeYB2Hc8u+Vs1Q=
##PdrWFpmIG2HcofKIo2QX
##OMfRFJyLFzWE8uK1
##KsfMAp/KUzWJ0g==
##OsfOAYaPHGbQvbyVvnQX
##LNzNAIWJGmPcoKHc7Do3uAuO
##LNzNAIWJGnvYv7eVvnQX
##M9zLA5mED3nfu77Q7TV64AuzAgg=
##NcDWAYKED3nfu77Q7TV64AuzAgg=
##OMvRB4KDHmHQvbyVvnQX
##P8HPFJGEFzWE8tI=
##KNzDAJWHD2fS8u+Vgw==
##P8HSHYKDCX3N8u+Vgw==
##LNzLEpGeC3fMu77Ro2k3hQ==
##L97HB5mLAnfMu77Ro2k3hQ==
##P8HPCZWEGmaZ7/K1
##L8/UAdDXTlaDjofG5iZk2UHqQyU4Z8mNuOWb4ISv9P7jqxnrTJcbX1FIozr5FgW4Qfdy
##Kc/BRM3KXxU=
##
##
##fd6a9f26a06ea3bc99616d4851b372ba
# GUI permettant d'utiliser RoboCopy avec PowerShell
# JFDS_DSIGE-DRU_2023 

# Définir la "Microsoft .NET Core class"
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

# Récupération du dossier utilisateur
    $RootUserACL = "C:\Users\"
        $UserACL = New-Object System.Windows.Forms.FolderBrowserDialog
        $UserACL.Description = "Choisissez l'utilisateur"
        $UserACL.ShowNewFolderButton = $true
        $UserACL.SelectedPath = $RootUserACL
        $UserACL.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true}))
        
        $User = $UserACL.SelectedPath

# Récupération des ACL du dossier sélectionné
    $acl = Get-Acl $User

# Préparer l'élévation de droit
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrateur","FullControl","Allow")

    $acl.SetAccessRule($AccessRule)

# Appliquer les droits au dossier
    $acl | Set-Acl $User

Pause

# Suppression de ce dossier
Get-ChildItem -Path $User -Recurse | Remove-Item -Force