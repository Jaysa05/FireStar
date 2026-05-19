/// @description Insert description here
// Verifica se o tempo de invencibilidade acabou (alarm[0] chegou a 0 ou menos)
if alarm[0] <= 0 {
	 // Diminui 1 ponto da vida do personagem
	 vida -= 1;
	 // Ativa o tempo de invencibilidade (define um valor para o alarm[0])
    // Durante esse tempo, o personagem não poderá levar dano novamente
	alarm[0] = inv_tempo;
}

// Executa o código no outro objeto envolvido na colisão (a semente)
with (other){
	// Destrói o outro objeto (faz a semente desaparecer da tela)
	instance_destroy()
}
