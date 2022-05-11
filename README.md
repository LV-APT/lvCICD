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

### lvEcho

    Parameter:
    1. All Parameters will be echoed to output.

### lvBuild

    Parameter:
    1. LabVIEW Project File : Path
    2. (option) name of Build Specification
       - Empty to build all
       - "" as Default
    3. (option) Name of Target
       - "My Computer" as Default

### SyncAllReposToLatest

    Parameter:
    1. (option) SearchingFolder : Path

### TriggerBuild

    Parameter:
    1. (option) SearchingFolder : Path

### ListAllReposBranches

    Parameter:
    1. (option) SearchingFolder : Path

### ListAllBuildSpecs

    Parameter:
    1. (option) SearchingFolder : Path

### vipm_BuildDailyVIP

    Parameter:
    1. vipb Path : Path
    2. (option) Install? : YES/NO
    3. (option) CopyDestPath : Path

### StartVITester

    Parameter:
    1. ProjectPath : Path
