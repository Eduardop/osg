OpenSceneGraph for Tablets (iOS and Android)
============================================

This repository contains two main branches:

### osg-iOS ###
### osg-android ###

osg-iOS
-------

### This branch is the OpenSceneGraph iOS port for SDK 5.0+ / ARC. ###

With this port, you will be able to build OSG for iOS out of the box.

### Features ###

* No prerequisites needed.
* Cmake not needed (the standard cmake 2.8.7 distribution is not
  compatible with Xcode 4.3). Xcode projects provided.
* Automatic reference counting (ARC) supported.
* iOS 5.0 SDK and higher supported.
* Xcode project built from scratch based on a clean iOS project.
* No need to have different projects for simulator and device, or
  for debug and release. Project looks and feels like a standard
  iOS project.
* Compilation with LLVM/Clang supported.
* Supports GLES1 (enabled by default).

README-OSG.txt contains the original README.txt contents.

### Build characteristics ###

* Built using Xcode 4.3.2, on Mac OS X 10.7.3.
* Built with iOS 5.1 SDK, targetting iOS 5.0.
* Includes precompiled Freetype from OpenFrameworks (in iOS/3rdparty).

* Disabled modules:
    * OpenThreads: qt, sproc, win32
    * osgQt

* Disabled plugins:

        cfg         curl        dae         dicom
        directshow  exr         fbx         ffmpeg
        gdal        gif         gta         inventor
        jp2         jpeg        nvtt        ogr
        pdf         pfb         png         qfont
        quicktime   qtkit       svg         tiff
        vnc         vrml        xine        zip

### Useful information ###

* The iOS specific content is in the iOS folder.
* Some patches were made to OSG sources. Use git diff to find what changed.

osg-android
-----------

### This branch is the Android port for SDK >= 20.0.3 and NDK >= r8b. ###

It is set up to use the shared C++ runtime library (gnustl_shared). 
I had linker problems with this NDK and the gnustl_static version.
This branch also patches a few cpp files that were erroring out during the
build, due to the NDK change to GCC 4.6.

* Builds for platform android-8.
* Builds for ABIs armeabi and armeabi-v7a.
* Does not use NEON, for compatibility.

Instructions:

* Clone the repository to a directory called OpenSceneGraph.
* Download http://www2.ai2.upv.es/difusion/osgAndroid/3rdpartyAndroid.zip.
* Unzip it inside OpenSceneGraph.
* Create a directory parallel to OpenSceneGraph for your osg build, called 
  osg-android.
* cd OpenSceneGraph; ./cmake.sh.
* cd ../osg-android; make -j'number_of_cpus' (e.g. make -j4).
* To build the sample:
  * cd ../OpenSceneGraph/examples/osgAndroidExampleGLES1.
  * edit jni/Android.mk and fix the osg build path - should be an absolute path
    to your osg-android directory.
  * build the JNI module with ndk-build.
  * build the Java module as you normally would (e.g. Eclipse).

Thanks
------

Many thanks to Robert Osfield and the OpenSceneGraph team.
