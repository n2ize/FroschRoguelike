shader_type canvas_item;

uniform float cell_size : hint_range(5.0, 100.0) = 30.0;
uniform float randomness : hint_range(0.0, 1.0) = 0.9;

vec2 hash2(vec2 p) {
    p = vec2(dot(p, vec2(127.1, 311.7)),
             dot(p, vec2(269.5, 183.3)));
    return fract(sin(p) * 43758.5453123);
}

void fragment() {
    vec2 px = UV / TEXTURE_PIXEL_SIZE;
    vec2 scaled = px / cell_size;
    vec2 base = floor(scaled);
    
    float min_dist = 999.0;
    vec2 best_uv = UV;
    
    for (int j = -2; j <= 2; j++) {
        for (int i = -2; i <= 2; i++) {
            vec2 cell = base + vec2(float(i), float(j));
            vec2 jitter = hash2(cell) * randomness;
            vec2 center = (cell + 0.5 + jitter) * cell_size;
            float d = distance(px, center);
            if (d < min_dist) {
                min_dist = d;
                best_uv = center * TEXTURE_PIXEL_SIZE;
            }
        }
    }
    
    COLOR = texture(TEXTURE, best_uv);
}