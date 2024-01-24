shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

void fragment() {
    vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV);
    vec4 inverted_color = vec4(1.0 - screen_color.rgb, screen_color.a); // Invert colors

    COLOR = inverted_color;
}
