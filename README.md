# LabVIEW CICD Scripts

## 说明

![image](https://user-images.githubusercontent.com/8196752/157785476-ca0301bd-0ad9-42e4-9bef-575c5199a989.png)

![image](https://user-images.githubusercontent.com/8196752/157785543-88407726-50de-4b36-ae82-544353124af5.png)

![image](https://user-images.githubusercontent.com/8196752/157785697-9444d467-aa67-4909-93f2-7af88a48534f.png)


## Dependence

 - [LabVIEW Command line Interface](https://www.ni.com/zh-cn/support/downloads/software-products/download.ni-labview-command-line-interface.html#)
 - OpenG Libraries
 - Hampel Software Engineering/GitAPI Libraries
 - JKI/VIPM API
 - JKI/VITester Library

## Command List

### lvEcho
    Parameter:
    1. All Parameters will be echoed to output.
### lvBuild
    Parameter:
    1. LabVIEW Project File Path
    2. (option) name of Build Specification [Empty to build all]
    3. (option) Name of Target [My Computer]
### SyncAllReposToLatest
    Parameter:
    1. (option) SearchingFolder :Path, Empty to use <lvapt.installer>
### TriggerBuild
    Parameter:
    1. (option) SearchingFolder :Path, Empty to use <lvapt.installer>
### ListAllReposBranches
    Parameter:
    1. (option) SearchingFolder :Path, Empty to use <lvapt.installer>
### ListAllBuildSpecs
    Parameter:
    1. (option) SearchingFolder :Path, Empty to use <lvapt.installer>

### vipm_BuildDailyVIP
    Parameter:
    1. vipb Path :Path
    2. (option) Install? :YES/NO
    3. (option) CopyDestPath:Path

### StartVITester
    Parameter:
    1. ProjectPath :Path