# Github Action for LabVIEW CICD (lvCICD)

[![Sync With AZDO](https://github.com/LV-APT/lvCICD/actions/workflows/Sync%20With%20AZDO.yml/badge.svg)](https://github.com/LV-APT/lvCICD/actions/workflows/Sync%20With%20AZDO.yml)
[![LabVIEW Project Tests](https://github.com/LV-APT/lvCICD/actions/workflows/LabVIEW%20Project%20Tests.yml/badge.svg)](https://github.com/LV-APT/lvCICD/actions/workflows/LabVIEW%20Project%20Tests.yml)

## Introduction

Use this customer-action in your github CICD description file.

    - name: [your_action_step_name]
      uses: LV-APT/lvCICD@[lvcicd_version]
      with:
        Operation: [operation_in_list]
        Parameter1: [parameter, optional]
        Parameter2: [parameter, optional]
        Parameter3: [parameter, optional]
        Parameter4: [parameter, optional]
        Parameter5: [parameter, optional]
        Parameter6: [parameter, optional]
        Parameter7: [parameter, optional]
        Parameter8: [parameter, optional]
        Parameter9: [parameter, optional]
        Parameter10: [parameter, optional]
        LabVIEW_Version: [LabVIEW_version,2019 or Later,2019 as default]
        Architecture: x86

### Pre-works

  1. Setup a self-host runner for your repo
  2. Install [LabVIEW Command line Interface](https://www.ni.com/zh-cn/support/downloads/software-products/download.ni-labview-command-line-interface.html#)
  3. Install dependent VIPM Libraries.

### Dependence

- [LabVIEW Command line Interface](https://www.ni.com/zh-cn/support/downloads/software-products/download.ni-labview-command-line-interface.html#)
- VIPM Libraries
  - [OpenG by OpenG](https://www.vipm.io/package/openg.org_lib_openg_toolkit/)
  - [Git API by Hampel Software Engineering](https://www.vipm.io/package/hse_lib_git_api/)
  - [VIPM API by JKI](https://www.vipm.io/package/jki_lib_vipm_api/)
  - [JKI VI Tester by JKI](https://www.vipm.io/package/jki_labs_tool_vi_tester/)

### Known Issues

- Only `10` Parameters could be defined
- The name of parameter is not intuitive due to limitation of github customer action.

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

vipm_ApplyVIPCFile.vi

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
