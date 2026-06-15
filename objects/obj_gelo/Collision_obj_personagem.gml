/// @description Causa dano no jogador
with (other) {
    if (alarm[0] <= 0) { // Se não estiver invulnerável
        vida -= 1;
        alarm[0] = inv_tempo;
        vveloc = -3; // Impulso para cima/trás
        hveloc = 2 * sign(x - other.x); // Empurra para o lado oposto
    }
}
