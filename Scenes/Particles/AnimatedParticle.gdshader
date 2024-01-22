shader_type spatial;
render_mode blend_add,depth_draw_opaque,cull_back,diffuse_burley,specular_schlick_ggx;

uniform sampler2D texture_albedo : hint_default_transparent;
uniform float numberOfFrames = 8;
uniform float numberOfTracks = 4;

varying float lifetime;
varying float trackNumber;

void vertex() {
    lifetime = INSTANCE_CUSTOM.y;
    trackNumber = 0.0;
}

void fragment() {
    float frameCoordinate = floor(lifetime * numberOfFrames) / numberOfFrames;
    float trackCoordinate = trackNumber / numberOfTracks;
    vec2 scaledUV = vec2(1.0 / numberOfFrames, 1.0 / numberOfTracks);
    vec2 shiftedUV = vec2(frameCoordinate, trackCoordinate);

    vec4 colour = texture(texture_albedo, UV * scaledUV + shiftedUV);

    ALBEDO = vec3(0, 0, 0);
    ALPHA = colour.a;
    EMISSION = colour.rgb;
}