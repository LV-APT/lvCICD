# Operation List

## Simple Operations

### `lvEcho` : Echo all the parameters to outputs

    Parameters:
    1. All Parameters will be echoed to output.

### `lvBuild` : Build the LabVIEW Projects specified

    Parameters:
    Parameter1. (required) LabVIEW Project File Path
    Parameter2. (option) name of Build Specification, Empty to build all
       - "" as Default
    Parameter3. (option) Name of Target
       - "My Computer" as Default

### `lvCopy` : Copy Files using LabVIEW VIs

    Parameters:
    Parameter1. (required) Dest-Folder/Files of Copy operation
    Parameter2-10. (optional) Source Files of Copy operation
        - If no '*' contained in file name, the specified file path will be used.
        - If '*' in file name, the file name is the search pattern. Files in folder with the pattern will all be used as source-path.

## Test Related Operations

### `StartVITester` : Start JKI VI Tester to run test cases

    Parameters:
    Parameter1. (required) LabVIEW Project File Path which contains the VITester test cases

## VIPM related Operations

Requirements:

- VIPM API is function of PRO Edition of VIPM. You need activate the license, or use a 30-days free-trial license.

### `vipm_InstallPackagesByPath` : install vip file

    Parameters:
    1. All Parameters accept a vip file path
       1. For regular file path, the full file path will be used.
       2. If the path not end with '.vip', recursively search will be executed the path with last part of path as pattern.
       3. If the last part of path contains '*', recursively search will be executed the path with last part of path as pattern.

### `vipm_InstallPackagesByName` : install vip by Package Name

    Parameters:
    1. All Parameters accept a package name, the latest version will be used.

### `vipm_unInstallPackagesByName` : unInstall vip by Package Name

    Parameters:
    1. All Parameters accept a package name, the latest version of installed will be used.

### `vipm_BuildDailyVIP` : Build VIPM Library

    Parameters:
    Parameter1. (required) vipb File Path
    Parameter2. (required) Install? : YES/NO
    Parameter3. (option) CopyDestPath : Path

### `vipm_ApplyVIPCFile` : Apply VIPC file

    Parameters:
    Parameter1. (required) VIPC File Path
       1. For regular file path, the full file path will be used.
       2. If the path not end with '.vipc', recursively search will be executed the path with last part of path as pattern.
       3. If the last part of path contains '*', recursively search will be executed the path with last part of path as pattern.

## Operations for build facility

These operations are part of a build facility for large project with multiple repos.
You need to pre-setup the folder contained all the repos organized as needed in the build machine.

Concepts

- **Build Spec Project**: A LabVIEW project with build spec in it and named as "_build.[0-9]*.xxxxx.lvproj"
- **Build Index**: The number part in name of **Build Spec Project**.

### `Batch_ListReposBranches` : list all the repos' current branch

    Parameters:
    Parameter1. (required) Searching Folder

### `Batch_SyncReposToLatest` : Sync all repos to latest on the active branch in specified folder


    Parameters:
    Parameter1. (required) Searching Folder

### `Batch_ListBuildSpecProjects` : list all the build spec projects with build order

    Notes:
    Smaller **Build Index** means higher priority.
    If no **Build Index** defined in name of **Build Spec Project**, the priority is lowest.
    The build order depends on the name characters. Usually no needs to care about the build orders.
    If you care about the build orders, or dependent relationship exists, add **Build Index** in **Build Spec Project**.

    Parameters:
    Parameter1. (required) Searching Folder

### `Batch_TriggerBuild` : Start build in specified folder

    Notes:
    Smaller **Build Index** means higher priority.
    If no **Build Index** defined in name of **Build Spec Project**, the priority is lowest.
    The build order depends on the name characters. Usually no needs to care about the build orders.
    If you care about the build orders, or dependent relationship exists, add **Build Index** in **Build Spec Project**.

    Parameters:
    Parameter1. (required) Searching Folder
