# Github Action for LabVIEW CICD (lvCICD)

## Introduction

Use this customer-action in your github CICD description file.

    - name: [your_action_step_name]
      uses: LV-APT/lvCICD@[lvcicd_version]
      with:
        Operation: [operation_in_list]
        Parameter1: [1st-parameter, optional]
        Parameter2: [2nd-parameter, optional]
        Parameter3: [3rd-parameter, optional]
        Parameter4: [4th-parameter, optional]
        Parameter5: [5th-parameter, optional]
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

- Only `5` Parameters could be defined
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

#### `vipm_BuildDailyVIP` : Build VIPM Library

    Requirements:
        - VIPM API is function of PRO Edition of VIPM. You need activate the license, or use a 30-days free-trial license.

    Parameters:
    Parameter1. (required) vipb File Path
    Parameter2. (required) Install? : YES/NO
    Parameter3. (option) CopyDestPath : Path

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
    If no **Build Index** defined in name of **Build Spec Project**, the priority is the least.
    The build order depends on the name characters. Usually it means the build order is not cared.
    If you care about the build orders, or dependent relationship exists, add **Build Index** in **Build Spec Project**.

    Parameters:
    Parameter1. (required) Searching Folder

#### `Batch_TriggerBuild` : Start build in specified folder

    Notes:
    Smaller **Build Index** means higher priority.
    If no **Build Index** defined in name of **Build Spec Project**, the priority is the least.
    The build order depends on the name characters. Usually it means the build order is not cared.
    If you care about the build orders, or dependent relationship exists, add **Build Index** in **Build Spec Project**.

    Parameters:
    Parameter1. (required) Searching Folder
