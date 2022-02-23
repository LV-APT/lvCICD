function git_force_sync_to_latest {
    param (
        [string]$RepoPath
    )

    git.exe checkout .
    git.exe pull origin

    echo $RepoPath
}

function git_switch_to_branch {
param (
        [string]$BranchName
    )

    git.exe checkout $BranchName
}

& D:\Workspace\lv-APT-facilities\[danger]git_switch_back_to_main.ps1 skip_pause
& D:\Workspace\lv-APT-facilities\[danger]git_sync_main_branch_of_all_repos.ps1 skip_pause
& Set-Location $args[0]
& echo $args[0]
& echo $args[1]
& git_switch_to_branch($args[1])
& git_force_sync_to_latest($PWD)
& LabVIEWCLI -OperationName RunVI -VIPath "D:\Workspace\Lv-APT-CI-CD\__TEST-Launcher.vi" -LabVIEWPath "C:\Program Files (x86)\National Instruments\LabVIEW 2019\LabVIEW.exe"