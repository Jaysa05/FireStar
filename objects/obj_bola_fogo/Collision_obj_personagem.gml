/// @description Insert description here
/// Evento de colisão da bola de fogo com o jogador

// Verifica se o jogador NÃO está no período de invencibilidade.
// alarm[0] funciona como um cronômetro.
// Se ele for menor ou igual a 0, significa que o jogador pode levar dano.
if (other.alarm[0] <= 0) {
	
	// Diminui 1 ponto da vida do jogador.
    // O "other" representa o jogador, pois este código pertence à bola de fogo.
	other.vida -=1;
	
	 // Inicia o tempo de invencibilidade do jogador.
    // Durante esse tempo, novas colisões não causarão dano.
	other.alarm[0] = other.inv_tempo;
}

// Destrói a bola de fogo após a colisão,
// fazendo com que ela desapareça da tela.
instance_destroy();