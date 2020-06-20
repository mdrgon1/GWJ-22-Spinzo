shader_type canvas_item;

vec2 distort(vec2 uv, float amount) {
	vec2 center = vec2(0.5, 0.5);
	return uv + (center - uv) * length(center - uv) * amount;
}

uniform float chrom_amount = 0.5;
uniform float chrom_spread = 0.1;
uniform float glare_size = 2;
uniform float glare_contrast = 2;
uniform float glare_amount = 1;

void fragment() {
	vec2 uv = SCREEN_UV;
	// chromatic aberration
	COLOR.r = textureLod(SCREEN_TEXTURE, distort(uv, chrom_amount - chrom_spread), 0.0).r;
	COLOR.g = textureLod(SCREEN_TEXTURE, distort(uv, chrom_amount), 0.0).g;
	COLOR.b = textureLod(SCREEN_TEXTURE, distort(uv, chrom_amount + chrom_spread), 0.0).b;
	
	// glare
	vec3 blurred;
	
	blurred.r = textureLod(SCREEN_TEXTURE, distort(uv, chrom_amount - chrom_spread), glare_size).r * glare_amount;
	blurred.g = textureLod(SCREEN_TEXTURE, distort(uv, chrom_amount), glare_size).g * glare_amount;
	blurred.b = textureLod(SCREEN_TEXTURE, distort(uv, chrom_amount + chrom_spread), glare_size).b * glare_amount;
	
	blurred -= glare_contrast;
	blurred = max(blurred, vec3(0, 0, 0));
	
	COLOR.rgb += blurred;
}
