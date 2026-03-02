shader_type canvas_item;

uniform float glow_strength = 1.5;
uniform vec4 glow_color : source_color = vec4(0.6, 0.9, 1.0, 1.0);

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	
	float alpha = col.a;
	vec4 glow = glow_color * alpha * glow_strength;
	
	COLOR = col + glow;
}