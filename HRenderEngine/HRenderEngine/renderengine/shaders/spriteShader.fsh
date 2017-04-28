precision mediump float;
precision lowp int;

varying vec2			vTexCoord;
//varying vec4            vVertexColor;

uniform sampler2D		uSampler;

void main (void)
{
    //gl_FragColor = vVertexColor;
    
   // gl_FragColor = vec4(vTexCoord.s,vTexCoord.t,0.0,1.0);
    gl_FragColor = texture2D(uSampler, vTexCoord);
}

