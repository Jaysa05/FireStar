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
// Aplica a posição sem limitar pelas bordas (para podermos ver se ele cai no abismo)
camera_set_view_pos(_cam, x - (_w / 2), y - (_h / 2));