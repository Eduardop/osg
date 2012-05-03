//
//  Shader.vsh
//  osgViewer-iOS
//
//  Created by Eduardo Poyart on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// This shader is not used on GLES 1 (fixed-function).

attribute vec4 osg_Vertex;
attribute vec3 osg_Normal;
attribute vec4 osg_Color;

varying lowp vec4 colorVarying;

uniform mat4 osg_ModelViewProjectionMatrix;
uniform mat3 osg_NormalMatrix;

void main()
{
    vec3 eyeNormal = normalize(osg_NormalMatrix * osg_Normal);
    vec3 lightPosition = vec3(0.0, 0.0, 1.0);
    
    float nDotVP = max(0.0, dot(eyeNormal, normalize(lightPosition)));
                 
    colorVarying = osg_Color * nDotVP;
    
    gl_Position = osg_ModelViewProjectionMatrix * osg_Vertex;
}
