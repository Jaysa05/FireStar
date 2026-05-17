

frutas++;

if (frutas >= 30){
	
	// Ativa o Alarm 0 com valor 480
	// 480 frames = 8 segundos em 60 FPS
	alarm[0] = 480;
	
	if (faca == true){
		
		// Adiciona +5 cargas
		faca_cargas += 5;
		
	} else {
		
		// Ativa o power-up da faca
		faca = true;
		
		// Dá 5 cargas iniciais
		faca_cargas = 5;
	}
	
	// Remove 30 frutas usadas no poder
	frutas -= 30; 
}

// 1 - Se possui 20 frutas ou mais
// 2 - Se a vida é menor que 5
if (frutas >= 20 && vida < 5){
		
	// Recupera +1 de vida
	vida++;
		
	// Remove 20 frutas
	frutas -= 20;
}

// Salva a vida globalmente
global.vida_save = vida;

// Salva a quantidade de frutas globalmente
global.frutas_save = frutas;

with(other){
		
	// Destrói a fruta
	instance_destroy();
}