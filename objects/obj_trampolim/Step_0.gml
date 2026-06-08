/// @description Insert description here
// Verifica duas coisas ao mesmo tempo:
// 1) Se o jogador está logo acima do trampolim (colisão por cima)
// 2) Se a animação do trampolim está no frame 1 (momento de impulso)
if (place_meeting(x, y - 5, obj_personagem) && floor(image_index) == 1){
	// Na fase 5, o impulso é gigante para jogar o personagem até o topo
	if (room == rm_fase5) {
		obj_personagem.vveloc = -25; 
	} else {
		// Nas outras fases, mantém o impulso normal
		obj_personagem.vveloc = -7.5;
	}
}