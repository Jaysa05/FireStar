// Colisão com o jogador (detecção retangular ampliada para alinhar com a hitbox do jogador)
var _alvo = collision_rectangle(bbox_left, bbox_top - 4, bbox_right, bbox_bottom + 12, obj_personagem, false, true);

if (_alvo != noone) {
    with (_alvo) {
        // Se o jogador não estiver no tempo de invencibilidade
        if (alarm[0] <= 0) {
            vida -= 1;
            alarm[0] = inv_tempo;
        }
    }
    
    // A bola de fogo se destrói ao atingir o jogador
    instance_destroy();
}
