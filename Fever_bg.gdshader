shader_type canvas_item;

uniform float speed = 1.0;

void fragment() {
    float time = TIME * speed;
    
    vec2 uv = (UV - vec2(0.5)) * vec2(2.0);
    float dist = length(uv);
    
    float angle = atan(uv.y, uv.x);
    
    vec3 color = vec3(
        (sin(angle * 10.0 + time) + 1.0) * 0.5,
        (cos(angle * 5.0 + time) + 1.0) * 0.5,
        (sin(angle * 15.0 + time) + 1.0) * 0.5
    );
    
    color *= smoothstep(0.0, 1.0, 1.0 - dist);
    
    COLOR = vec4(color, 1.0);
}


//Leave comments if you want If you want a white light effect with a transparent background
//shader_type canvas_item;

//void fragment() {
//    float time = TIME;
    
//    vec2 uv = (UV - vec2(0.5)) * vec2(2.0);
//    float dist = length(uv);
//    float angle = atan(uv.y, uv.x);
    
//   float opacity = sin(angle * 5.0 + time) * 0.5 + 0.5;
    
//    opacity *= smoothstep(0.0, 1.0, 1.0 - dist);
    
//    COLOR = vec4(1.0, 1.0, 1.0, opacity);
//}