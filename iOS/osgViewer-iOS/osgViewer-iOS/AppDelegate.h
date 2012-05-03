//
//  AppDelegate.h
//  osgViewer-iOS
//
//  Created by Eduardo Poyart on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//Created by Thomas Hogarth 2009

#include <osgDB/ReadFile>
#include <osg/MatrixTransform>
#include <osg/CameraNode>
#include <osgText/Text>
#include <osgViewer/Viewer>

#import <UIKit/UIKit.h>


@interface AppDelegate : NSObject <UIApplicationDelegate, UIAccelerometerDelegate> {
    
    UIWindow* _window; //main application window
    
    UIAccelerationValue        accel[3];
    
    osg::ref_ptr<osgViewer::Viewer> _viewer;
    osg::ref_ptr<osg::MatrixTransform> _root;
    osg::ref_ptr<osg::CameraNode> _hudCamera;
}

@property (nonatomic, retain) /*IBOutlet*/ UIWindow *_window;

- (void)updateScene;

@end

