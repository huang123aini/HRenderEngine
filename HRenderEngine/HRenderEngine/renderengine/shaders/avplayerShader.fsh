precision mediump float;

uniform sampler2D    uSamplerY;
uniform sampler2D    uSamplerUV;
uniform mat3         uColorConversionMatrix;

varying mediump vec2 vTexCoord;

void main()
{
    mediump vec3 yuv;
    
    yuv.x = texture2D(uSamplerY, vTexCoord).r - (16.0/255.0);
    yuv.yz = texture2D(uSamplerUV, vTexCoord).rg - vec2(0.5, 0.5);
    
    lowp vec3 rgb = uColorConversionMatrix * yuv;
    
    gl_FragColor = vec4(rgb, 1);
}


