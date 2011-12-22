# Warnings

This is an xcconfig file to make it easy for you to turn on a large suite of useful warnings in your Xcode project. These warnings catch bugs, so turning them on may identify bugs you can fix now and having them on will prevent bugs later.

If you have an existing project you've developed with these warnings enabled, you probably will have a number of warnings after enabling them. Be strong and fix them—they are bugs, so fixing the warnings is fixing bugs.

The file also turns on Treat Warnings as Errors—so you can't just ignore warnings; you must fix them in order to be able to build—and the setting to run the Clang Static Analyzer in every build, which will find even more bugs (mostly leaks and crashers).

If you are new to Objective-C, you may find that you encounter build errors more frequently when using these settings. That is correct, expected, and good—the errors are bugs that would otherwise have gone undetected! Use these settings to identify your bad habits and things you don't fully understand, and take the opportunities to learn. You will learn better and faster with these warnings enabled.

## The xcconfig file

### Usage

1. Copy it to your own project's root directory (the directory containing the .xcodeproj package).
2. Add it to the project. In a modern project, it should be at the top level, either at the top of the list or below all of the per-target groups.
3. Edit the project object (the very topmost item in the Project Navigator).
4. Select the project, not any target.
5. Select the Info tab.
6. Under Configurations, expand both/all of the configurations.
7. For each configuration, set the pop-up menu for the project to “Warnings” (which is the xcconfig file you just added).

### What if you're already using an xcconfig file?

Xcode supports preprocessor directives in xcconfig files, so you can #include the Warnings file from your existing xcconfig file.

## The test project

WarningsTest is an Xcode project containing a unit test bundle target. The project uses the xcconfig file, and the tests demonstrate the kinds of bugs that the file tells the compiler to warn about.

### Usage

Open it in Xcode, hold down on the verb button (the one that says Run by default) and choose Test. This will attempt to build the unit test bundle and run the tests.

It will fail, because the tests are all written to demonstrate the warnings, not to test other code. (There is no code under test.) Because of all the warnings and the Treat Warnings as Errors setting, the build will never succeed.

## Credits

- Peter Hosey made [a list of important warnings](http://boredzo.org/blog/archives/2009-11-07/warnings).
- Steven Fisher [made the original xcconfig file of warning settings](http://tewha.net/2010/11/xcode-warnings/).
