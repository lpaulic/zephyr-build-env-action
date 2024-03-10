# Zephyr build environment action

This action provides the Zephyr build environment to be used to build against 
[freestanding](https://docs.zephyrproject.org/latest/develop/application/index.html#zephyr-freestanding-application) 
applications.

## Inputs

## `command`

**Optional** Command to be run in the docker action. Supported values are: `build` and `Test`. Default `build`.
The `build` command will run the Zephyr's west build command with specified project source directory and board name.
The `test` commnad will also run the Zephyr's west build command with specified project source directory and board name
and additianally passing the `-DBUILD_TESTING=yes` cmake option. After building it will run `ctest` that will run the 
project's tests.

## `directory`

**Optional** The path to the project's source directory. Default `${{ github.workspace }}`.

## `board`

**Optional** The board name for which to build the project for. Default `native_posix`.

## Example usage

- Example 1:
uses: actions/zephyr-build-env-action@v1
with:
    command: 'build'

- Example 2:
uses: actions/zephyr-build-env-action@v1
with:
    command: 'build'
    directory: '${{ github.workspace }}/subdirectory'

- Example 3:
uses: actions/zephyr-build-env-action@v1
with:
    command: 'build'
    board: 'qemu_x86'
