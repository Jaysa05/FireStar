/// @description Câmera que segue o personagem
// Obtém a câmera principal da view.
var _cam = view_camera[0];

// Obtém a largura da área visível da câmera.
var _w = camera_get_view_width(_cam);

// Obtém a altura da área visível da câmera
var _h = camera_get_view_height(_cam);

// Se o personagem existir, faz o objeto da câmera seguir a posição dele suavemente (lerp)
if (instance_exists(obj_personagem))
{
	// 0.1 é a taxa de interpolação (velocidade de suavização). 
	// Valores maiores fazem seguir mais rápido, valores menores fazem seguir mais devagar.
	x = lerp(x, obj_personagem.x, 0.1);
	y = lerp(y, obj_personagem.y, 0.1);
}

// Calcula a posição horizontal da câmera.
// Subtrai metade da largura para manter o jogador centralizado.
var _cam_x = x - (_w / 2);

// Calcula a posição vertical da câmera.
// Subtrai metade da altura para manter o jogador centralizado.
var _cam_y = y - (_h / 2);

// Impede que a câmera ultrapasse os limites da sala em qualquer fase.
// Usamos max(0, room_width - _w) para evitar problemas se a sala for menor que a câmera.
_cam_x = clamp(_cam_x, 0, max(0, room_width - _w));
_cam_y = clamp(_cam_y, 0, max(0, room_height - _h));

// Move a câmera para a posição calculada.
camera_set_view_pos(_cam, _cam_x, _cam_y);