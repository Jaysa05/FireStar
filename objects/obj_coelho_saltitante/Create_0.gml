event_inherited(); 
// Executa o código do objeto pai (herança).
// Isso faz com que este objeto herde variáveis e comportamentos
// como vida, dano, sistema de hit, etc.

sprite_morrendo = spr_cebola_morrendo;

// Define qual sprite será usado quando o inimigo morrer.
// "spr_coelho_morrendo" deve ser a animação de morte do coelho.

item_drop = noone; 
// Define o que o inimigo vai dropar ao morrer.
// "noone" significa que ele não vai dropar nenhum item.

// Velocidades
vveloc = 0;

gravidade = 0.4; 
// Define a força da gravidade aplicada ao objeto.
// A cada frame ele será puxado para baixo.

forca_pulo = -8;       
// Define a força do pulo.
// Valor negativo faz o objeto subir (no eixo Y).
// Quanto mais negativo, mais alto o pulo.

no_chao = false; 
// Variável booleana que indica se o objeto está no chão.
// Começa como falso (ele ainda não está no chão).

// Temporizador do pulo
timer_pulo = 0; 
// Contador que será usado para controlar quando o inimigo vai pular.
// Começa em 0.

intervalo_pulo = 60;  
// Define o intervalo entre os pulos.
// 120 frames ≈ 2 segundos (considerando 60 FPS).