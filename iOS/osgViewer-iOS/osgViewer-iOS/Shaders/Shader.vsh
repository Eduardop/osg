//
//  Shader.vsh
//  osgViewer-iOS
//
//  Created by Eduardo Poyart on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

precision mediump float;

attribute vec4 osg_Vertex;
attribute vec3 osg_Normal;
attribute vec4 osg_Color;

uniform mat4 osg_ModelViewProjectionMatrix;
uniform mat4 osg_ModelViewMatrix;
uniform mat3 osg_NormalMatrix;
uniform vec3 lightViewSpace;

varying vec4 v_position;
varying vec3 v_normal;
varying vec3 v_surfaceToLight;
varying vec3 v_surfaceToView;
varying vec4 v_color;

void main() 
{
  v_position = osg_ModelViewProjectionMatrix * osg_Vertex;
  v_normal = osg_NormalMatrix * osg_Normal;
  vec3 vertexViewSpace = (osg_ModelViewMatrix * osg_Vertex).xyz;
  v_surfaceToLight = lightViewSpace - vertexViewSpace;
  v_surfaceToView =  -vertexViewSpace;
  v_color = osg_Color;
  gl_Position = v_position;
}


/*
uniform mat4 worldViewProjection;
uniform vec3 lightWorldPos;
uniform mat4 world;
uniform mat4 viewInverse;
uniform mat4 worldInverseTranspose;
attribute vec4 position;
attribute vec3 normal;
varying vec4 v_position;
varying vec3 v_normal;
varying vec3 v_surfaceToLight;
varying vec3 v_surfaceToView;
void main() {
  v_position = (worldViewProjection * position);
  v_normal = (worldInverseTranspose * vec4(normal, 0)).xyz;
  v_surfaceToLight = lightWorldPos - 
                          (world * position).xyz;
  v_surfaceToView = (viewInverse[3] - (world * position)).xyz;
  gl_Position = v_position;
}
*/
