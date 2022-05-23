# Customer Action for LabVIEW CI/CD (lvCICD)

[![Sync With AZDO](https://github.com/LV-APT/lvCICD/actions/workflows/Sync%20With%20AZDO.yml/badge.svg)](https://github.com/LV-APT/lvCICD/actions/workflows/Sync%20With%20AZDO.yml)
[![LabVIEW Project Tests](https://github.com/LV-APT/lvCICD/actions/workflows/LabVIEW%20Project%20Tests.yml/badge.svg)](https://github.com/LV-APT/lvCICD/actions/workflows/LabVIEW%20Project%20Tests.yml)

## Introduction

This repo is used to complete the missing part of LabVIEW operations in Continuous integration and continuous deployment(CI/CD).

You can use **`lvCICD`** to:

1. *Build your LabVIEW project/LabVIEW FPGA bitfile*
2. *[TODO] Start Vi Analyzer*
3. *Run LabVIEW test cases*
4. *Install/uninstall VIPM libraries(vip)*
5. *Apply VIPM VIPC file(vipc)*
6. *Setup Large LabVIEW build facility*
7. *Add your own operation, [Click link to see how to contribute to it](docs/How-to-contribute.md)*

### Latest Version : `lvCICD@v0.2`

### Dependence

- [LabVIEW 2019 or Later](https://www.ni.com/zh-cn/support/downloads/software-products/download.labview.html)
- [LabVIEW Command line Interface](https://www.ni.com/zh-cn/support/downloads/software-products/download.ni-labview-command-line-interface.html#)
- VIPM Libraries: [VIPM vipc file Download Link](https://github.com/LV-APT/lvCICD/files/8727600/lvCICD.zip)
  - [OpenG by OpenG](https://www.vipm.io/package/openg.org_lib_openg_toolkit/) (LabVIEW >= 2009)
  - [Git API by Hampel Software Engineering](https://www.vipm.io/package/hse_lib_git_api/) (LabVIEW  >= 2016)
  - [VIPM API by JKI](https://www.vipm.io/package/jki_lib_vipm_api/) (LabVIEW  >= 2013)
  - [JKI VI Tester by JKI](https://www.vipm.io/package/jki_labs_tool_vi_tester/) (LabVIEW  >= 2013)

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
  - If current user's desktop folder is ***C:\Users\Bob\Desktop***
    - ***"[Desktop]\abc.txt"*** -->  ***C:\Users\Bob\Desktop\abc.txt***
  - If LabVIEW 2019(32bit) is used
    - ***[vi.lib]\Utility\error.llb*** --> ***"C:\Program Files (x86)\National Instruments\LabVIEW 2019\vi.lib\Utility\error.llb"***
  - If set ***"SyncPath=C:\Sync"*** in **Environment Variables**
    - ***[SyncPath]\abc.txt*** --> ***"C:\Sync\abc.txt"***

## Pre-works

  1. Setup a self-host runner for your repo.
     1. Add your self-hosted Windows Machine to pool [`Azure DevOps`](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/v2-windows?view=azure-devops) | [`Github`](https://docs.github.com/en/enterprise-server@3.2/actions/hosting-your-own-runners/adding-self-hosted-runners)
     2. Tips:
        1. **[!IMPORTANT!]** Please read [Security hardening for GitHub Actions](https://docs.github.com/en/enterprise-server@3.5/actions/security-guides/security-hardening-for-github-actions#hardening-for-self-hosted-runners) before using a self-host runner in public repos.
        Best practice:
           1. Do NOT use `pull_request` trigger for public repos.
           2. Only use actions created by GitHub or verified creators in marketplace.
           3. Use github secret to store your critical information instead of using plant-text in workflow yml file.
        2. Running Powershell Scripts needs to be enabled on the system. [Reference](https://www.partitionwizard.com/clone-disk/running-scripts-is-disabled-on-this-system.html)
        3. If you set the runner/agent application as a service, please set the account to current user. You can use `whoami` command to check the current user.
  2. Install LabVIEW and its components needed with [NI Package Manger](https://www.ni.com/zh-cn/support/downloads/software-products/download.package-manager.html)
  3. Install [LabVIEW Command line Interface](https://www.ni.com/zh-cn/support/downloads/software-products/download.ni-labview-command-line-interface.html#)
  4. Install dependent VIPM Libraries ([lvCICD.vipc](https://github.com/LV-APT/lvCICD/files/8727600/lvCICD.zip)).

## Usage

### Github Actions

Add this customer-action to `steps` session in github actions yml file.

> Copy this snippet to github workflow yml file and change the `[xxx]` following your self-hosted agent/runner configuration.

> Check [**lvCICD Operation-List**](docs/Operation-List.md) for detailed information.

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

**Example 1**: use `lvEcho` to check runner/agent ready for lvCICD tools.

    - name: TestEnvironment
      uses: LV-APT/lvCICD@v0.2
      with:
        Operation: lvEcho
        Parameter1: "line1"
        Parameter2: "line2"
      	Parameter3: "line3"

**Example 2**: use `StartVITester` to run unit test cases in "CICD-LabVIEW-Adapter.lvproj".

    - name: Run lvCICD Test cases with VITester
      uses: LV-APT/lvCICD@v0.2
      with:
        Operation: StartVITester
        Parameter1: ${{ github.workspace }}\LabVIEW-Adapter\CICD-LabVIEW-Adapter.lvproj

### Azure DevOps

#### Step 1: Add Variables needed for lvCICD in Azure DevOps Pipeline yml file.

> Change the `lvCICD-Tool-Version`/`LabVIEW-Version`/`LabVIEW-Architecture` following your self-hosted agent/runner configuration.

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

#### Step 2: Add task for Downloading lvCICD tools to `steps` session of Azure DevOps Pipeline yml file.

> Copy this snippet to your Azure DevOps Pipeline yml file as it is. You don't need to change it.

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

#### Step 3: Add task of lvCICD to DevOps Pipeline yml file.

> Copy this snippet to DevOps Pipeline yml file and change the `[xxx]` following your self-hosted agent/runner configuration.

> Check [**lvCICD Operation-List**](docs/Operation-List.md) for detailed information.

    - task: PowerShell@2
      displayName: [your_action_step_name]
      inputs:
        targetType: 'inline'
        script: |
          # Write your PowerShell commands here.
          & $(lvCICD) [Operation] [Parameter1] [Parameter2] [Parameter3] ...

**Example 1**: use `lvEcho` to check runner/agent ready for lvCICD tools.

    - task: PowerShell@2
      displayName: lvEcho
      inputs:
        targetType: 'inline'
        script: |
          & $(lvCICD) lvEcho a b c

**Example 2**: use `lvBuild` to build "lvCICD-Example.lvproj" which contains a build spec in it.

    - task: PowerShell@2
      displayName: lvBuild
      inputs:
        targetType: 'inline'
        script: |
          Write-Host "$(Pipeline.Workspace)"
          Write-Host "$(Build.Repository.LocalPath)"
          & $(lvCICD) lvBuild '$(Build.Repository.LocalPath)\lvCICD-Example.lvproj'
