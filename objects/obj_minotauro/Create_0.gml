// Executa primeiro o código do objeto pai.
// Isso permite herdar configurações comuns a todos os inimigos.
event_inherited();


// ========================
// VIDA
// ========================

// Quantidade de vida inicial do Minotauro.
vida = 15;

// ========================
// MOVIMENTO E FÍSICA
// ========================

// Velocidade usada quando o Minotauro está perseguindo o jogador.
veloc_chase = 0.9;

// Velocidade usada durante a investida.
veloc_investida = 3.0;

// Velocidade vertical (movimento para cima e para baixo).
// Começa zerada porque o inimigo nasce parado.
vveloc = 0;

// Velocidade horizontal (movimento para esquerda e direita).
// Também começa zerada.
hveloc = 0;

// Intensidade da gravidade aplicada ao Minotauro.
gravidade = 0.3;

// Direção inicial do personagem.
// 1 = olhando para a direita
// -1 = olhando para a esquerda
direct = 1;

// ========================
// COLISÃO
// ========================

// Garante que o sprite comece com escala normal.
// Evita que a caixa de colisão nasça deformada.
image_xscale = 1;

// Define uma máscara de colisão fixa baseada no sprite parado.
//
// Sem isso, cada sprite poderia ter um tamanho diferente
// de colisão, fazendo o Minotauro entrar em paredes ou
// ficar preso ao trocar de animação.
//
// Com mask_index, ele usa sempre a mesma área de colisão.
mask_index = spr_minotauro;

// ========================
// MÁQUINA DE ESTADOS
// ========================


// Estado atual do Minotauro.
//
// Possíveis estados:
// "chase"              -> perseguindo o jogador
// "prepara_investida"  -> preparando a investida
// "investida"          -> correndo em alta velocidade
// "ataque_2"           -> segundo ataque
// "ataque_3"           -> terceiro ataque
// "exhausted"          -> cansado após atacar

estado = "chase";

// Cronômetro utilizado para controlar a duração dos estados
timer_estado = 0;

// Tempo de espera antes de usar uma nova investida.
//
// 180 frames = aproximadamente 3 segundos
// (considerando 60 FPS).
//
// Isso impede que o chefe ataque imediatamente
// quando a luta começa.
cooldown_investida = 180;

// Define se o Minotauro pode receber dano.
//
// true  = pode receber dano
// false = está invulnerável
vulneravel = false; // Começa invencível (por 5 segundos)
timer_vulnerabilidade = 300; // 300 frames a 60 FPS (5 segundos)

// ========================
// CONTROLE DOS ATAQUES
// ========================

// Define qual será o próximo ataque utilizado.
//
// 0 = investida
// 1 = ataque_2
// 2 = ataque_3
proximo_ataque = 0;

// ========================
// SPRITES
// ========================

// Sprite usada quando o Minotauro está parado.
sprite_idle = spr_minotauro;

// Sprite usada ao caminhar para a direita.
sprite_andando_dir = spr_minotauro_andando_direita;

// Sprite usada ao caminhar para a esquerda.
sprite_andando_esq = spr_minotauro_andando_esquerda;

// Sprite usada durante a investida.
sprite_investida = spr_investida_cortante_minotauro;

// Sprite/animação reproduzida quando o Minotauro morre.
sprite_morrendo = spr_minotauro_morrendo;

