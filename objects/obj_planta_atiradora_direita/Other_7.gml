/// @description Insert description here
// Para a animação da sprite (faz ela parar completamente)
image_speed = 0;

// Define o frame atual da animação como 0 (primeiro frame)
// Normalmente esse frame é a planta "fechada" ou parada
image_index = 0;

// Define um tempo de espera usando o alarm[0]
// O valor 120 significa que o jogo vai esperar 120 frames
// Se o jogo estiver rodando a 60 FPS, isso equivale a 2 segundos
alarm[0] = 120;
