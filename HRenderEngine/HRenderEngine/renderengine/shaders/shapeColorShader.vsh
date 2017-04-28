precision mediump float;
precision lowp int;

attribute highp vec4	aPosition;
attribute vec2          aTexCoord;

//attribute vec4          aVertexColor;

//varying vec4            vVertexColor;
varying vec2            vTexCoord;

uniform mat4			uModelViewProjectionMatrix;


void main(void)
{
   // vVertexColor = aVertexColor;
    vTexCoord = aTexCoord;
    gl_Position = uModelViewProjectionMatrix * aPosition;
    
}
