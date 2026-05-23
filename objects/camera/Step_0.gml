/// @description Câmera que segue o personagem suavemente
if (instance_exists(obj_personagem)) {
    // Move o objeto câmera suavemente em direção ao personagem
    x = lerp(x, obj_personagem.x, 0.05);
    y = lerp(y, obj_personagem.y, 0.05);
}

// Obtém a câmera do viewport 0
var _cam = view_camera[0];
var _view_w = camera_get_view_width(_cam);
var _view_h = camera_get_view_height(_cam);

// Calcula a posição centralizada, limitando aos bordos da sala
var _cam_x = clamp(x - _view_w / 2, 0, room_width - _view_w);
var _cam_y = clamp(y - _view_h / 2, 0, room_height - _view_h);

// Aplica à câmera do viewport
camera_set_view_pos(_cam, _cam_x, _cam_y);
