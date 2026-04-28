/// @description Insert description here
// Soma 1 ao número de frutas do jogador
frutas++;

// Verifica se o jogador tem 30 ou mais frutas para ganhar invencibilidade de 6 segundos
if(frutas >= 30){
	
	// Ativa o alarme 0 com valor 360 (isso funciona como um cronômetro)
    // 360 frames = 6 segundos
	alarm[0] = 360;
	
	 // Remove 30 frutas do total do jogador
    // É como "pagar" para ativar a habilidade
	frutas -= 30;
}

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