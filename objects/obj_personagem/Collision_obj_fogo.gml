/// @description Colisão com fogo
// Só toma dano se não estiver invencível
if (!invencivel) {
    vida -= 1;
    invencivel = true;
    timer_invencibilidade = tempo_invencibilidade;
}
