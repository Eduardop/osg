osg-iOS
-------

Welcome to the OpenSceneGraph iOS port for SDK 5.0+ / ARC.

With this port, you will be able to build OSG for iOS out of the box.

    * No prerequisites needed.
    * Cmake not needed (the standard cmake 2.8.7 distribution is not
      compatible with Xcode 4.3). Xcode projects provided.
    * Automatic reference counting supported.
    * iOS 5.0 SDK and higher supported.
    * Xcode projet built from scratch based on a clean iOS project.
    * No need to have different projects for simulator and device.
    * Same for debug and release.
    * Clang supported.

README-OSG.txt contains the original README.txt contents.

* Built using Xcode 4.3.2.
* Built with iOS 5.1 SDK, targetting iOS 5.0.
* Includes precompiled Freetype from OpenFrameworks (in iOS/3rdparty).
* Supports GLES1 and GLES2.
* Defaults to GLES2 (OSG_GLES2_AVAILABLE).
* User needs to write own shaders.

* Disabled modules:
    * OpenThreads: qt, sproc, win32
    * osgQt
    
* Disabled plugins:
    * cfg
    * curl
    * dae
    * dicom
    * directshow
    * exr
    * fbx
    * ffmpeg
    * gdal
    * gif
    * gta
    * inventor
    * jp2
    * jpeg
    * nvtt
    * ogr
    * pdf
    * pfb
    * png
    * qfont
    * quicktime
    * qtkit
    * svg
    * tiff
    * vnc
    * vrml
    * xine
    * zip

Many thanks to Robert Osfeld and the OpenSceneGraph team.