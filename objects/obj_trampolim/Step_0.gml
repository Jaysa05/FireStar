// 1) Se o jogador está logo acima do trampolim (colisão por cima)
// 2) Se a animação do trampolim está no frame 1 (momento de impulso)
if (place_meeting(x, y - 5, obj_personagem) && floor(image_index) == 1){
    // -12 é um impulso forte (bem maior que um pulo normal)
	obj_personagem.vveloc = -7.5;
}