//
//  AppDelegate.m
//  osgViewer-iOS
//
//  Created by Eduardo Poyart on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// Adapted from code by Thomas Hogarth 2009

#import "AppDelegate.h"
#include "osgPlugins.h"
#include <osgGA/TrackballManipulator>
#include <osg/ShapeDrawable>
#include <osgViewer/api/IOS/GraphicsWindowIOS> 
#include <osgDB/FileUtils>

#define kAccelerometerFrequency     30.0 // Hz
#define kFilteringFactor            0.1

@implementation AppDelegate

@synthesize _window;


bool loadShaderSource(osg::Shader* obj, const std::string& fileName )
{
    std::string fqFileName = osgDB::findDataFile(fileName);
    if( fqFileName.length() == 0 )
    {
        std::cout << "File \"" << fileName << "\" not found." << std::endl;
        return false;
    }
    bool success = obj->loadShaderSourceFromFile( fqFileName.c_str());
    if ( !success  )
    {
        std::cout << "Couldn't load file: " << fileName << std::endl;
        return false;
    }
    else
    {
        return true;
    }
}

//
// Called once app has finished launching, create the viewer then realize. Can't call viewer->run as will 
// block the final inialization of the windowing system.
//

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    // get the screen size
    CGRect lFrame = [[UIScreen mainScreen] bounds];
    unsigned int w = lFrame.size.width;
    unsigned int h = lFrame.size.height;
    
    // create the main window at screen size
    self._window = [[UIWindow alloc] initWithFrame: lFrame]; 
    
    // show window
    [_window makeKeyAndVisible];    
    
    // create our graphics context directly so we can pass our own window 
    osg::ref_ptr<osg::GraphicsContext::Traits> traits = new osg::GraphicsContext::Traits;
    
    // Init the Windata Variable that holds the handle for the Window to display OSG in.
    osg::ref_ptr<osg::Referenced> windata = new osgViewer::GraphicsWindowIOS::WindowData(_window);
    
    // Setup the traits parameters
    traits->x = 0;
    traits->y = 0;
    traits->width = w;
    traits->height = h;
    traits->depth = 16; // keep memory down, default is currently 24
    //traits->alpha = 8;
    //traits->stencil = 8;
    traits->windowDecoration = false;
    traits->doubleBuffer = true;
    traits->sharedContext = 0;
    traits->setInheritedWindowPixelFormat = true;
    //traits->windowName = "osgViewer";
    
    traits->inheritedWindowData = windata;
    
    // Create the Graphics Context
    osg::ref_ptr<osg::GraphicsContext> graphicsContext = osg::GraphicsContext::createGraphicsContext(traits.get());
    
    // create the viewer    
    _viewer = new osgViewer::Viewer();
    // if the context was created then attach to our viewer
    if(graphicsContext)
    {
        osg::Camera* cam = _viewer->getCamera();
        cam->setGraphicsContext(graphicsContext);
        cam->setViewport(new osg::Viewport(0, 0, traits->width, traits->height));
        double fv, a, n, f;
        cam->getProjectionMatrixAsPerspective(fv, a, n, f);
        cam->setProjectionMatrixAsPerspective(fv, (float)traits->width/(float)traits->height, n, f);
    }
    
    // create scene and attch to viewer
    
    // create root
    _root = new osg::MatrixTransform();    
    
    // load and attach scene model
    osg::ref_ptr<osg::Node> model = (osgDB::readNodeFile("crate.osgt"));
    _root->addChild(model);
    
    osg::StateSet* stateset = _root->getOrCreateStateSet();
    
    osg::Program* programObject = new osg::Program;
    osg::Shader* vertexObject = new osg::Shader( osg::Shader::VERTEX );
    osg::Shader* fragmentObject = new osg::Shader( osg::Shader::FRAGMENT );
    programObject->addShader( fragmentObject );
    programObject->addShader( vertexObject );
    loadShaderSource( vertexObject, "Shader.vsh" );
    loadShaderSource( fragmentObject, "Shader.fsh" );
    
    stateset->setAttributeAndModes(programObject, osg::StateAttribute::ON);    
    
    // create and attach ortho camera for hud text
    _hudCamera = new osg::CameraNode;
    
    // set the projection matrix
    _hudCamera->setProjectionMatrix(osg::Matrix::ortho2D(0,w,0,h));
    
    // set the view matrix    
    _hudCamera->setReferenceFrame(osg::Transform::ABSOLUTE_RF);
    _hudCamera->setViewMatrix(osg::Matrix::identity());
    
    // only clear the depth buffer
    _hudCamera->setClearMask(GL_DEPTH_BUFFER_BIT);
    
    // draw subgraph after main camera view.
    _hudCamera->setRenderOrder(osg::CameraNode::POST_RENDER);
    _root->addChild(_hudCamera.get());
    
    // attcg text to hud
    
    osg::ref_ptr<osgText::Text> text = new osgText::Text; 
    osg::ref_ptr<osg::Geode> textGeode = new osg::Geode();
    stateset = textGeode->getOrCreateStateSet();
    stateset->setMode(GL_LIGHTING,osg::StateAttribute::OFF);

    textGeode->addDrawable( text );
    _hudCamera->addChild(textGeode.get());
    std::string timesFont("OpenSans-Regular.ttf");
    osg::Vec3 position = osg::Vec3(w/2.0f, h-h/8.0f, 0.0f);
    //osg::Vec3 delta(0.0f,-120.0f,0.0f);

    text->setFont(timesFont);
    text->setCharacterSize(20.0,1.0);
    text->setColor(osg::Vec4(0.8,0.8,0.8,1.0)); 
    text->setPosition(position);
    text->setMaximumHeight(480);
    text->setMaximumWidth(320);
    text->setAlignment(osgText::Text::CENTER_CENTER );  
    text->setText("OpenSceneGraph-iOS");
    
    _viewer->setSceneData(_root.get());
    _viewer->setCameraManipulator(new osgGA::TrackballManipulator);
    _viewer->setThreadingModel(osgViewer::Viewer::SingleThreaded);//SingleThreaded DrawThreadPerContext
    
    //_viewer->realize();
    
    osg::setNotifyLevel(osg::DEBUG_FP);
    
    [NSTimer scheduledTimerWithTimeInterval:1.0/30.0 target:self selector:@selector(updateScene) userInfo:nil repeats:YES]; 
    
    // Configure and start accelerometer
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kAccelerometerFrequency)];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
}

//
// Timer called function to update our scene and render the viewer
//

- (void)updateScene {
    _viewer->frame();
}

//
// Accelorometer
//

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{
    // Use a basic low-pass filter to only keep the gravity in the accelerometer values
    accel[0] = acceleration.x * kFilteringFactor + accel[0] * (1.0 - kFilteringFactor);
    accel[1] = acceleration.y * kFilteringFactor + accel[1] * (1.0 - kFilteringFactor);
    accel[2] = acceleration.z * kFilteringFactor + accel[2] * (1.0 - kFilteringFactor);
}


- (void)dealloc {
    _root = NULL;
    _viewer = NULL;
    //[super dealloc];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    _root = NULL;
    _viewer = NULL;
}

@end
