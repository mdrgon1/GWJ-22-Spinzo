shader_type canvas_item;

vec2 distort(vec2 uv, float amount) {
	vec2 center = vec2(0.5, 0.5);
	return uv + (center - uv) * length(center - uv) * amount;
}

uniform float amount = 0.5;
uniform float spread = 0.1;

void fragment() {
	vec2 uv = SCREEN_UV;
	// chromatic aberration
	COLOR.r = textureLod(SCREEN_TEXTURE, distort(uv, amount - spread), 0.0).r;
	COLOR.g = textureLod(SCREEN_TEXTURE, distort(uv, amount), 0.0).g;
	COLOR.b = textureLod(SCREEN_TEXTURE, distort(uv, amount + spread), 0.0).b;
}
