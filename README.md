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
* Compilation with Clang supported.

README-OSG.txt contains the original README.txt contents.

Build characteristics
---------------------

* Built using Xcode 4.3.2, on Mac OS X 10.7.3.
* Built with iOS 5.1 SDK, targetting iOS 5.0.
* Includes precompiled Freetype from OpenFrameworks (in iOS/3rdparty).
* Supports GLES1 and GLES2.
* Defaults to GLES2 (OSG_GLES2_AVAILABLE).
* User needs to write own shaders.

* Disabled modules:
    * OpenThreads: qt, sproc, win32
    * osgQt
    
* Disabled plugins:

<table><tr>
<td>  cfg      </td>
<td>  curl     </td>
<td>  dae      </td>
<td>  dicom    </td></tr><tr>
<td>  directshow </td>
<td>  exr      </td>
<td>  fbx      </td>
<td>  ffmpeg   </td></tr><tr>
<td>  gdal     </td>
<td>  gif      </td>
<td>  gta      </td>
<td>  inventor </td></tr><tr>
<td>  jp2      </td>
<td>  jpeg     </td>
<td>  nvtt     </td>
<td>  ogr      </td></tr><tr>
<td>  pdf      </td>
<td>  pfb      </td>
<td>  png      </td>
<td>  qfont    </td></tr><tr>
<td>  quicktime </td>
<td>  qtkit    </td>
<td>  svg      </td>
<td>  tiff     </td></tr><tr>
<td>  vnc      </td>
<td>  vrml     </td>
<td>  xine     </td>
<td>  zip      </td></tr>
</table>

Useful information
------------------

* The iOS specific content is in the iOS folder.
* Some patches were made to OSG sources. Use git diff to find what changed.

Thanks
------

Many thanks to Robert Osfield and the OpenSceneGraph team.
