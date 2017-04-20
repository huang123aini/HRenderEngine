
attribute vec4 aPosition;
attribute vec2 aTexCoord;

varying vec2   vTexCoord;

uniform mat4   uModelViewProjectionMatrix;


void main ()
{
    vTexCoord  = aTexCoord;
    gl_Position = uModelViewProjectionMatrix * aPosition; //与模型视图投影矩阵相乘
}

