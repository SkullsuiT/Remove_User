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
Get-ChildItem -Path $User -Recurse | Remove-Item Recurse -Force