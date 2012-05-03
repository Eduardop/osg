//
//  Shader.fsh
//  osgViewer-iOS
//
//  Created by Eduardo Poyart on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// This shader is not used on GLES 1 (fixed-function).

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
