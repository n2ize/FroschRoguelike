shader_type canvas_item;

uniform float cell_size : hint_range(10.0, 150.0) = 60.0;
uniform float speed : hint_range(0.0, 2.0) = 0.3;

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
    float second_dist = 999.0;
    vec2 best_uv = UV;
    
    for (int j = -2; j <= 2; j++) {
        for (int i = -2; i <= 2; i++) {
            vec2 cell = base + vec2(float(i), float(j));
            vec2 jitter = hash2(cell);
            vec2 animated = jitter + 0.3 * sin(TIME * speed + jitter * 6.28);
            vec2 center = (cell + 0.5 + animated) * cell_size;
            float d = distance(px, center);
            if (d < min_dist) {
                second_dist = min_dist;
                min_dist = d;
                best_uv = center * TEXTURE_PIXEL_SIZE;
            } else if (d < second_dist) {
                second_dist = d;
            }
        }
    }
    
    COLOR = texture(TEXTURE, best_uv);
}