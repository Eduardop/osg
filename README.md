osg-iOS
=======

### Welcome to the OpenSceneGraph iOS port for SDK 5.0+ / ARC. ###

With this port, you will be able to build OSG for iOS out of the box.

Features
--------

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
* For GLES2 support:
    * user needs to write own shaders, and add code to pass
      in uniforms to OSG.
    * a future release will simplify these tasks.

README-OSG.txt contains the original README.txt contents.

Build characteristics
---------------------

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

Useful information
------------------

* The iOS specific content is in the iOS folder.
* Some patches were made to OSG sources. Use git diff to find what changed.

Thanks
------

Many thanks to Robert Osfield and the OpenSceneGraph team.
