precision mediump float;
precision lowp int;

varying vec2			vTexCoord;
varying vec4            vColor;

uniform sampler2D		uSampler;

void main (void)
{
    //gl_FragColor = vColor;
    gl_FragColor = texture2D(uSampler, vTexCoord);
    
    
}

