shader_type canvas_item;

uniform float cell_size : hint_range(1.0, 150.0) = 60.0;
uniform float speed : hint_range(0.0, 2.0) = 0.3;
uniform vec4 color_dark : source_color = vec4(0.17, 0.17, 0.16, 1.0);
uniform vec4 color_mid : source_color = vec4(0.27, 0.27, 0.25, 1.0);
uniform vec4 color_light : source_color = vec4(0.37, 0.37, 0.35, 1.0);

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
    vec2 best_cell = vec2(0.0);
    
    for (int j = -2; j <= 2; j++) {
        for (int i = -2; i <= 2; i++) {
            vec2 cell = base + vec2(float(i), float(j));
            vec2 jitter = hash2(cell);
            
            // Animation — jede Zelle bewegt sich leicht
            vec2 animated = jitter + 0.3 * sin(TIME * speed + jitter * 6.28);
            vec2 center = (cell + 0.5 + animated) * cell_size;
            
            float d = distance(px, center);
            if (d < min_dist) {
                second_dist = min_dist;
                min_dist = d;
                best_cell = jitter;
            } else if (d < second_dist) {
                second_dist = d;
            }
        }
    }
    
    // Zellgrenzen für leichten Edge-Effekt
    float edge = second_dist - min_dist;
    
    // Farbe basierend auf Zell-Hash
    float cell_value = fract(dot(best_cell, vec2(7.3, 13.7)));
    
    vec4 col;
    if (cell_value < 0.33) {
        col = color_dark;
    } else if (cell_value < 0.66) {
        col = color_mid;
    } else {
        col = color_light;
    }
    
    // Leicht hellere Kanten
    col += vec4(0.05) * smoothstep(0.0, 8.0, edge);
    
    COLOR = col;
}