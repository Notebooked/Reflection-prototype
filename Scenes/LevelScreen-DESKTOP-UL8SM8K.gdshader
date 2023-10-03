shader_type canvas_item;

uniform sampler2D capsule_texture;

uniform float lod: hint_range(0.0, 5) = 0.0;

uniform float hdr_threshold: hint_range(0.0, 5) = 0.0;

uniform sampler2D screen_text = hint_screen_texture();

void fragment(){
	vec4 color = texture(capsule_texture, SCREEN_UV, lod);
	
	vec4 currentColor = texture(capsule_texture, UV);
	
	vec3 currentColorHDR = max(vec3(0), currentColor.rgb - vec3(hdr_threshold));
	
	vec3 c = max(vec3(0), color.rgb - vec3(hdr_threshold / 2.0) - currentColorHDR) * 3.0;
	
	COLOR = currentColor;
}