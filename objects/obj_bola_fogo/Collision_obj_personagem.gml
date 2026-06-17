/// @description Insert description here
// Tira 1 de vida do jogador ('other' se refere ao jogador atingido)
if (other.alarm[0] <= 0) {
    other.vida -= 1; 
    other.alarm[0] = other.inv_tempo; // Ativa o tempo de invencibilidade do jogador
}

// Destrói a bola de fogo para ela sumir após acertar
instance_destroy(); 

