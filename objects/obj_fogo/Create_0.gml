/// @description Insert description here
// Define o tempo entre os ataques em frames (ex: 60 frames = 1 segundo se o jogo rodar a 60 FPS)
tempo_ataque = 360; // 360 frames = 6 segundos

// Inicia o alarme pela primeira vez
alarm[0] = tempo_ataque;

// Valores negativos ficam mais "próximos" da tela, garantindo que o fogo apareça na frente do cenário
depth = -100;


