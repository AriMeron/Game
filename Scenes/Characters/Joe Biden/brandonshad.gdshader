shader_type spatial;
render_mode unshaded;

uniform float time_speed = 1.0;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
    // Animated grain effect
    float noise = rand(FRAGCOORD.xy * TIME * time_speed);
    
    // Base red color
    vec3 base_color = vec3(1.0, 0.0, 0.0);

    // Combine base color with noise
    ALBEDO = base_color * noise;
	ALPHA = 0.7;
}
