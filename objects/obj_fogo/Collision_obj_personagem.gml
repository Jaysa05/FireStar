// 1. Só aplica o dano se o jogador NÃO estiver invencível
if (!other.invencivel) {
    other.vida -= 1;
    
    // Ativa a invencibilidade e inicia o cronômetro no personagem
    other.invencivel = true;
    other.timer_invencibilidade = other.tempo_invencibilidade;
}

// 2. O fogo sempre se destrói ao tocar no jogador (mesmo que ele esteja invencível)
instance_destroy();
