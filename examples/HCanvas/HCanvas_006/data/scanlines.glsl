/*
	A basic scanline shader for Processing, based on MattiasCRT: https://www.shadertoy.com/view/Ms23DR
*/

#define PROCESSING_TEXTURE_SHADER

#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D texture;
varying vec4 vertTexCoord;
uniform vec2 resolution;
uniform vec2 screenres;
uniform float time;

void main(void) {

	vec3 iResolution = vec3(resolution,0.0);
	float iGlobalTime = time;

	vec2 q = vertTexCoord.xy / iResolution.xy;
	vec2 uv = q;
	vec4 col = texture2D(texture, vertTexCoord.xy);

	float scans = clamp( 0.35+0.35*sin(3.5 * iGlobalTime + uv.y * screenres.y * 2.0), 0.0, 1.0);
	float s = pow(scans,1.7);
	col = col * vec4(0.4 + 0.7 * s) ;

	col*=1.0-0.65*vec4(clamp((mod(vertTexCoord.x, 2.0)-1.0)*2.0,0.0,1.0));

	gl_FragColor = col;
}
