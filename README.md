# Github Action for LabVIEW CICD (lvCICD)

[![Sync With AZDO](https://github.com/LV-APT/lvCICD/actions/workflows/Sync%20With%20AZDO.yml/badge.svg)](https://github.com/LV-APT/lvCICD/actions/workflows/Sync%20With%20AZDO.yml)
[![LabVIEW Project Tests](https://github.com/LV-APT/lvCICD/actions/workflows/LabVIEW%20Project%20Tests.yml/badge.svg)](https://github.com/LV-APT/lvCICD/actions/workflows/LabVIEW%20Project%20Tests.yml)

## Introduction

This repo is used to complete the missing part of LabVIEW operations in Continuous integration and continuous deployment(CI/CD).

You can use **`lvCICD`** to:

1. *Build your LabVIEW project/LabVIEW FPGA bitfile*
2. *Install/uninstall VIPM libraries(vip)*
3. *Apply VIPM VIPC file(vipc)*
4. *Run LabVIEW test cases*
5. *Setup Large LabVIEW build facility*
6. *<span style="color: pink;">Add your own operation, Click link to see how to contribute to it.</span>*

### Latest Version : `lvCICD@v0.2`
### Dependence

- [LabVIEW 2019 or Later](https://www.ni.com/zh-cn/support/downloads/software-products/download.labview.html)
- [LabVIEW Command line Interface](https://www.ni.com/zh-cn/support/downloads/software-products/download.ni-labview-command-line-interface.html#)
- VIPM Libraries: [VIPM vipc file Download Link](https://github.com/LV-APT/lvCICD/files/8727600/lvCICD.zip)
  - [OpenG by OpenG](https://www.vipm.io/package/openg.org_lib_openg_toolkit/)
  - [Git API by Hampel Software Engineering](https://www.vipm.io/package/hse_lib_git_api/)
  - [VIPM API by JKI](https://www.vipm.io/package/jki_lib_vipm_api/)
  - [JKI VI Tester by JKI](https://www.vipm.io/package/jki_labs_tool_vi_tester/)

### Known Issues

- Only `10` Parameters could be defined
- The name of parameter is not intuitive due to limitation of github customer action. Check the Operation List for what it stands for.
- Path definition. You can use `[GLOBAL_MACRO]` in relative path parameter.

  Available `GLOBAL_MACRO`:
  - `vi.lib`: vi.lib folder of LabVIEW
  - `user.lib`: user.lib folder of LabVIEW
  - `temp`: temporary folder of System
  - `desktop`: current user's desktop folder
  - You can also use `System Environment Variable` defined in **Environment Variables**

  Examples:
  - If current user's desktop folder is ***C:\Users\Bob\Desktop\***
    - ***"[Desktop]\abc.txt"*** -->  ***C:\Users\Bob\Desktop\abc.txt***
  - If LabVIEW 2019(32bit) is used
    - ***[vi.lib]\Utility\error.llb*** --> ***"C:\Program Files (x86)\National Instruments\LabVIEW 2019\vi.lib\Utility\error.llb"***
  - If set ***"SyncPath=C:\Sync"*** in **Environment Variables**
    - ***[SyncPath]\abc.txt*** --> ***"C:\Sync\abc.txt"***

## Pre-works

  1. Setup a self-host runner for your repo.
  2. Install LabVIEW and its components needed with NI Package Manger.
  3. Install [LabVIEW Command line Interface](https://www.ni.com/zh-cn/support/downloads/software-products/download.ni-labview-command-line-interface.html#)
  4. Install dependent VIPM Libraries ([lvCICD.vipc](https://github.com/LV-APT/lvCICD/files/8727600/lvCICD.zip)).

## Usage

### Github Actions

Add this customer-action to `steps` session in github actions yml file.

> *<span style="color: pink;">Copy this snippet to github workflow yml file and change the `[xxx]` following your own sensoria.</span>*

    - name: [your_action_step_name]
      uses: LV-APT/lvCICD@[lvcicd_version]
      with:
        Operation: [optional, operation_in_list, 'lvEcho' as default]
        Parameter1: [optional, parameter]
        Parameter2: [optional, parameter]
        Parameter3: [optional, parameter]
        Parameter4: [optional, parameter]
        Parameter5: [optional, parameter]
        Parameter6: [optional, parameter]
        Parameter7: [optional, parameter]
        Parameter8: [optional, parameter]
        Parameter9: [optional, parameter]
        Parameter10: [optional, parameter]
        LabVIEW_Version: [optional, LabVIEW_version,2019 or Later,2019 as default]
        Architecture: [optional, x86 or x64, x86 as default]

Example 1: use `lvEcho` to check runner/agent ready for lvCICD tools.

      - name: TestEnvironment
        uses: LV-APT/lvCICD@v0.2
        with:
          Operation: lvEcho
          Parameter1: "line1"
          Parameter2: "line2"
          Parameter3: "line3"

Example 2: use `StartVITester` to run unit test cases in "CICD-LabVIEW-Adapter.lvproj".

      - name: Run lvCICD Test cases with VITester
        uses: LV-APT/lvCICD@v0.2
        with:
          Operation: StartVITester
          Parameter1: ${{ github.workspace }}\LabVIEW-Adapter\CICD-LabVIEW-Adapter.lvproj

### Azure DevOps

#### Step 1

Add Variables needed for lvCICD in Azure DevOps Pipeline yml file.

*<span style="color: pink;">Change the `lvCICD-Tool-Version`/`LabVIEW-Version`/`LabVIEW-Architecture` following your own sensoria.</span>*

    variables:
    - name: lvCICD-Tool-URL
    value: https://github.com/LV-APT/lvCICD
    - name: lvCICD-Tool-LocalPath
    value: $(Agent.TempDirectory)\lvCICD
    - name: lvCICD-Tool-Version
    value: v0.2
    - name: lvCICD
    value: '"$(lvCICD-Tool-LocalPath)\lvCICD.ps1" $(LabVIEW-Version) $(LabVIEW-Architecture)'
    - name: LabVIEW-Version
    value: '2019'
    - name: LabVIEW-Architecture
    value: x86

#### Step 2

Add task for Downloading lvCICD tools to `steps` session of Azure DevOps Pipeline yml file.

*<span style="color: pink;">Copy this snippet to your Azure DevOps Pipeline yml file as it is. You don't need to change it.</span>*

     - task: PowerShell@2
       displayName: Clone lvCICD Tools
       inputs:
           targetType: 'inline'
           script: |
           # Show Parameters
           Write-Host "lvCICD-Tool-LocalPath = $(lvCICD-Tool-LocalPath)"
           Write-Host "lvCICD-Tool-URL = $(lvCICD-Tool-URL)"
           Write-Host "lvCICD-Tool-Version = $(lvCICD-Tool-Version)"
           # Remove temp files
           Write-Host "if ( Test-Path -Path ""$(lvCICD-Tool-LocalPath)"") { Remove-Item -Recurse -Force ""$(lvCICD-Tool-LocalPath)"" }"
           if ( Test-Path -Path "$(lvCICD-Tool-LocalPath)") { Remove-Item -Recurse -Force "$(lvCICD-Tool-LocalPath)" }
           # Clone Tools
           Write-Host "git clone --progress --depth 1 --branch $(lvCICD-Tool-Version) ""$(lvCICD-Tool-URL)"" ""$(lvCICD-Tool-LocalPath)"""
           git clone --progress --depth 1 --branch $(lvCICD-Tool-Version) "$(lvCICD-Tool-URL)" "$(lvCICD-Tool-LocalPath)"

#### Step 3

Add task of lvCICD to DevOps Pipeline yml file.

*<span style="color: pink;">Copy this snippet to DevOps Pipeline yml file and change the `[xxx]` following your own sensoria.</span>*

     - task: PowerShell@2
       displayName: [your_action_step_name]
       inputs:
         targetType: 'inline'
         script: |
           # Write your PowerShell commands here.
           & $(lvCICD) [Operation] [Parameter1] [Parameter2] [Parameter3] ...

Example 1: use `lvEcho` to check runner/agent ready for lvCICD tools.

     - task: PowerShell@2
       displayName: lvEcho
       inputs:
         targetType: 'inline'
         script: |
           & $(lvCICD) lvEcho a b c

Example 2: use `lvBuild` to build "lvCICD-Example.lvproj" which contains a build spec in it.

     - task: PowerShell@2
       displayName: lvBuild
       inputs:
         targetType: 'inline'
         script: |
           Write-Host "$(Pipeline.Workspace)"
           & $(lvCICD) lvBuild '$(Build.Repository.LocalPath)\lvCICD-Example.lvproj'

## Operation List

### Simple Operations

#### `lvEcho` : Echo all the parameters to outputs

    Parameters:
    1. All Parameters will be echoed to output.

#### `lvBuild` : Build the LabVIEW Projects specified

    Parameters:
    Parameter1. (required) LabVIEW Project File Path
    Parameter2. (option) name of Build Specification, Empty to build all
       - "" as Default
    Parameter3. (option) Name of Target
       - "My Computer" as Default

#### `lvCopy` : Copy Files using LabVIEW VIs

    Parameters:
    Parameter1. (required) Dest-Folder/Files of Copy operation
    Parameter2-10. (optional) Source Files of Copy operation
        - If no '*' contained in file name, the specified file path will be used.
        - If '*' in file name, the file name is the search pattern. Files in folder with the pattern will all be used as source-path.

### Test Related Operations

#### `StartVITester` : Start JKI VI Tester to run test cases

    Parameters:
    Parameter1. (required) LabVIEW Project File Path which contains the VITester test cases

### VIPM related Operations

Requirements:

- VIPM API is function of PRO Edition of VIPM. You need activate the license, or use a 30-days free-trial license.

#### `vipm_InstallPackagesbyPath` : install vip file

    Parameters:
    1. All Parameters accept a vip file path
       1. For regular file path, the full file path will be used.
       2. If the path not end with '.vip', recursively search will be executed the path with last part of path as pattern.
       3. If the last part of path contains '*', recursively search will be executed the path with last part of path as pattern.

#### `vipm_InstallPackagesbyName` : install vip by Package Name

    Parameters:
    1. All Parameters accept a package name, the latest version will be used.

#### `vipm_unInstallPackagesbyName` : unInstall vip by Package Name

    Parameters:
    1. All Parameters accept a package name, the latest version of installed will be used.

#### `vipm_BuildDailyVIP` : Build VIPM Library

    Parameters:
    Parameter1. (required) vipb File Path
    Parameter2. (required) Install? : YES/NO
    Parameter3. (option) CopyDestPath : Path

#### `vipm_ApplyVIPCFile` : Apply VIPC file

    Parameters:
    Parameter1. (required) VIPC File Path
       1. For regular file path, the full file path will be used.
       2. If the path not end with '.vipc', recursively search will be executed the path with last part of path as pattern.
       3. If the last part of path contains '*', recursively search will be executed the path with last part of path as pattern.

### Operations for build facility

These operations are part of a build facility for large project with multiple repos.
You need to pre-setup the folder contained all the repos organized as needed in the build machine.

Concepts

- **Build Spec Project**: A LabVIEW project with build spec in it and named as "_build.[0-9]*.xxxxx.lvproj"
- **Build Index**: The number part in name of **Build Spec Project**.

#### `Batch_ListReposBranches` : list all the repos' current branch

    Parameters:
    Parameter1. (required) Searching Folder

#### `Batch_SyncReposToLatest` : Sync all repos to latest on the active branch in specified folder


    Parameters:
    Parameter1. (required) Searching Folder

#### `Batch_ListBuildSpecProjects` : list all the build spec projects with build order

    Notes:
    Smaller **Build Index** means higher priority.
    If no **Build Index** defined in name of **Build Spec Project**, the priority is lowest.
    The build order depends on the name characters. Usually no needs to care about the build orders.
    If you care about the build orders, or dependent relationship exists, add **Build Index** in **Build Spec Project**.

    Parameters:
    Parameter1. (required) Searching Folder

#### `Batch_TriggerBuild` : Start build in specified folder

    Notes:
    Smaller **Build Index** means higher priority.
    If no **Build Index** defined in name of **Build Spec Project**, the priority is lowest.
    The build order depends on the name characters. Usually no needs to care about the build orders.
    If you care about the build orders, or dependent relationship exists, add **Build Index** in **Build Spec Project**.

    Parameters:
    Parameter1. (required) Searching Folder
