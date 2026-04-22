/// @description Insert description here
// Soma 1 ao número de frutas do jogador
frutas++;

// Verifica se o jogador tem 20 ou mais frutas E a vida é menor que 5
if ( frutas >= 20 && vida < 5){
	// Aumenta a vida em 1
	vida++;
	
	// Remove 20 frutas (pois foram usadas para ganhar a vida)
	frutas -= 20;
	
	// Salva o valor da vida em uma variável global (para não perder o progresso)
	global.vida_save = vida;
}

// Salva a quantidade atual de frutas em uma variável global
global.frutas_save = frutas;

// destrói a fruta
with (other){
	instance_destroy()
}