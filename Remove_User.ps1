# GUI permettant d'utiliser RoboCopy avec PowerShell
# JFDS_DSIGE-DRU_2023 

# Définir la "Microsoft .NET Core class"
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

# Récupération du dossier utilisateur
    $RootFolder = "C:\Users\"
        $UserFolder = New-Object System.Windows.Forms.FolderBrowserDialog
        $UserFolder.Description = "Choisissez l'utilisateur"
        $UserFolder.ShowNewFolderButton = $true
        $UserFolder.SelectedPath = $RootUserFolder
        $UserFolder.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true}))
        
        $User = $UserFolder.SelectedPath

# Récupération des ACL du dossier sélectionné
    $acl = Get-Acl $User

# Préparer l'élévation de droit
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrateur","FullControl","Allow")

    $acl.SetAccessRule($AccessRule)

# Appliquer les droits au dossier
    $acl | Set-Acl $User

# Suppression de ce dossier
$count = 0
while (($count -ne 5) -and (Get-Item -Path $User $true))
{
    $count++;
    {
        Get-ChildItem -Path $User | Remove-Item -Recurse -Force
    }
}