osg-iOS
=======

### Welcome to the OpenSceneGraph iOS port for SDK 5.0+ / ARC. ###

With this port, you will be able to build OSG for iOS out of the box.

* No prerequisites needed.
* Cmake not needed (the standard cmake 2.8.7 distribution is not
  compatible with Xcode 4.3). Xcode projects provided.
* Automatic reference counting supported.
* iOS 5.0 SDK and higher supported.
* Xcode project built from scratch based on a clean iOS project.
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

<table>
<tr>
<td>cfg</td>
<td>curl</td></tr><tr>
<td>dae</td>
<td>dicom</td></tr><tr>
<td>directshow</td>
<td>exr</td></tr><tr>
<td>fbx</td>
<td>ffmpeg</td></tr><tr>
<td>gdal</td>
<td>gif</td></tr><tr>
<td>gta</td>
<td>inventor</td></tr><tr>
<td>jp2</td>
<td>jpeg</td></tr><tr>
<td>nvtt</td>
<td>ogr</td></tr><tr>
<td>pdf</td>
<td>pfb</td></tr><tr>
<td>png</td>
<td>qfont</td></tr><tr>
<td>quicktime</td>
<td>qtkit</td></tr><tr>
<td>svg</td>
<td>tiff</td></tr><tr>
<td>vnc</td>
<td>vrml</td></tr><tr>
<td>xine</td>
<td>zip</td></tr>
</table>

Many thanks to Robert Osfield and the OpenSceneGraph team.
