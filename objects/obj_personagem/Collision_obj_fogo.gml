/// @description Colisão com fogo
// Só toma dano se não estiver invencível (unificado com alarm[0] e invencivel)
if (!invencivel && alarm[0] <= 0) {
    vida -= 1;
    alarm[0] = inv_tempo;
    invencivel = true;
    }
