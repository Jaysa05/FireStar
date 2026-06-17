/// @description Câmera que segue o personagem
if (instance_exists(obj_personagem)) {
    // Se a câmera estiver muito longe (primeiro frame), pula direto para o personagem
    if (point_distance(x, y, obj_personagem.x, obj_personagem.y) > 400) {
        x = obj_personagem.x;
        y = obj_personagem.y;
    }
    
    // Segue o personagem suavemente
    x = lerp(x, obj_personagem.x, 0.1);
    y = lerp(y, obj_personagem.y, 0.1);
}
var _cam = view_camera[0];
var _w = camera_get_view_width(_cam);
var _h = camera_get_view_height(_cam);

var _cam_x = x - (_w / 2);
var _cam_y = y - (_h / 2);

// Limita a câmera dentro dos limites da sala apenas na Fase 5 para não mostrar o limbo
if (room == rm_fase5) {
    _cam_x = clamp(_cam_x, 0, room_width - _w);
    _cam_y = clamp(_cam_y, 0, room_height - _h);
}

// Aplica a posição
camera_set_view_pos(_cam, _cam_x, _cam_y);