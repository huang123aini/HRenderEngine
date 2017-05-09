uniform sampler2D    uSamplerY;
uniform sampler2D    uSamplerU;
uniform sampler2D    uSamplerV;
varying mediump vec2 vTexCoord;

void main()
{
    highp float y = texture2D(uSamplerY, vTexCoord).r;
    highp float u = texture2D(uSamplerU, vTexCoord).r - 0.5;
    highp float v = texture2D(uSamplerV, vTexCoord).r - 0.5;
    
    highp float r = y +             1.402 * v;
    highp float g = y - 0.344 * u - 0.714 * v;
    highp float b = y + 1.772 * u;
    
    gl_FragColor = vec4(r , g, b, 1.0);
}


