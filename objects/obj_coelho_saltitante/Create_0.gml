event_inherited(); 
// como vida, dano, sistema de hit, etc.

sprite_morrendo = spr_cebola_morrendo;

// "spr_coelho_morrendo" deve ser a animação de morte do coelho.

item_drop = noone; 
// "noone" significa que ele não vai dropar nenhum item.

// Velocidades
vveloc = 0;

gravidade = 0.4; 
// A cada frame ele será puxado para baixo.

forca_pulo = -8;       
// Valor negativo faz o objeto subir (no eixo Y).
// Quanto mais negativo, mais alto o pulo.

no_chao = false; 
// Variável booleana que indica se o objeto está no chão.

// Temporizador do pulo
timer_pulo = 0; 
// Contador que será usado para controlar quando o inimigo vai pular.

intervalo_pulo = 60;  
// 120 frames ≈ 2 segundos (considerando 60 FPS).