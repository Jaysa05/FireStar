/// @description Insert description here
event_inherited(); 
// 1. FORÇA ele a caminhar todos os frames ignorando a limitação do hspeed!
if (indo_direita == true) {
    x = x + 1;        // Move pra direita forçado
    image_xscale = -1; // Olha pra direita
} else {
    x = x - 1;         // Move pra esquerda forçado
    image_xscale = 1;  // Olha pra esquerda
}
// 2. Cria uma Colisão muito mais forte e inteligente!
// Se ele enxergar uma cerca no próximo passo, ele já vira antes de ficar preso!
if (place_meeting(x + 1, y, obj_parede_inimigo) || place_meeting(x - 1, y, obj_parede_inimigo)) {
    // Inverte o lado! (Se é falso vira verdadeiro, e vice-versa)
    indo_direita = !indo_direita; 
}
