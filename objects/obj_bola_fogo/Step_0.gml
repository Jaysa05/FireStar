// Colisão com o jogador
var _alvo = instance_place(x, y, obj_personagem);

if (_alvo != noone) {
    with (_alvo) {
        if (alarm[0] <= 0) {
            vida -= 1;
            alarm[0] = inv_tempo;
        }
    }
    
    // A bola de fogo se destrói ao atingir o jogador
    instance_destroy();
}
