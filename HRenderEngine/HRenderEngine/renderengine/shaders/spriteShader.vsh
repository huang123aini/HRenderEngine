precision mediump float;
precision lowp int;


attribute highp vec4	aPosition;
attribute vec2			aTexCoord;
attribute vec4          aColor;
attribute vec3          aNormal;

varying vec2			vTexCoord;
varying vec4            vColor;

uniform mat4			uModelViewMatrix;
uniform mat4			uProjectionMatrix;
void main(void)
{
    vTexCoord    = aTexCoord;
    vColor       = aColor;
    
    gl_Position  = uProjectionMatrix * uModelViewMatrix * aPosition;
    
}
