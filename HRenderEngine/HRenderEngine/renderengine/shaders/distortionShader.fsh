precision mediump float;
varying vec2 vRedTextureCoord;
varying vec2 vBlueTextureCoord;
varying vec2 vGreenTextureCoord;
varying float vVignette;
uniform sampler2D uSampler;
void main()
{
    gl_FragColor = vVignette * vec4(texture2D(uSampler, vRedTextureCoord).r,
                                    texture2D(uSampler, vGreenTextureCoord).g,
                                    texture2D(uSampler, vBlueTextureCoord).b, 1.0);
}

