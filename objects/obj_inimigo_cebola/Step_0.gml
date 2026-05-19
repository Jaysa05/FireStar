/// @description Insert description here

// Chama o código do evento pai (se existir), garantindo que qualquer lógica herdada seja executada
event_inherited();

// Verifica se o inimigo ainda está vivo
if vida > 0 {

    // -----------------------------
    // Movimentação para a direita
    // -----------------------------
    if direct == 0 {  // Se estiver andando para a direita

        // Verifica se haverá colisão com outro inimigo ou parede na próxima posição
        if place_meeting(x + veloc, y, obj_parede_inimigo){
            direct = 1;  // Se colidir, muda a direção para esquerda
        } else {
            x += veloc;  // Se não colidir, anda normalmente para a direita
        }

        sprite_index = spr_cebola_andando_direita;  // Define o sprite de andando para a direita
    }

    // -----------------------------
    // Movimentação para a esquerda
    // -----------------------------
    else if direct == 1 {  // Se estiver andando para a esquerda

        // Verifica se haverá colisão à esquerda
        if place_meeting(x - veloc, y, obj_parede_inimigo){
            direct = 0;  // Se colidir, muda a direção para direita
        } else {
            x -= veloc;  // Se não colidir, anda normalmente para a esquerda
        }

        sprite_index = spr_cebola_andando_esquerda;  // Define o sprite de andando para a esquerda
    }

    // -----------------------------
    // Verifica se o inimigo morreu
    // -----------------------------
    if vida <= 0 {
        instance_destroy();  // Remove o inimigo do jogo
    }
}