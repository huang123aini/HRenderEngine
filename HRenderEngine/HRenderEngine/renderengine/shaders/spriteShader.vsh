precision mediump float;
precision lowp int;


attribute highp vec4	aPosition;
attribute vec2			aTexCoord;
//attribute vec4          aVertexColor;

varying vec2			vTexCoord;
//varying vec4            vVertexColor;

uniform mat4			uModelViewProjectionMatrix;

void main(void)
{
    vTexCoord    = aTexCoord;
   // vVertexColor = aVertexColor;
    
    gl_Position  = uModelViewProjectionMatrix * aPosition;
    
}
