// Executa o evento Create do objeto pai.
// Isso faz o Monstro de Gelo herdar comportamentos básicos do inimigo.
event_inherited();

// =====================================================
// SISTEMA DE ALEATORIEDADE
// =====================================================

// Reinicia a semente dos números aleatórios.
// Faz com que eventos aleatórios não aconteçam sempre da mesma forma.
randomize();

// =====================================================
// FÍSICA E MOVIMENTO
// =====================================================

// Velocidade de caminhada do monstro.
// Como ele é gigante, se move devagar.
spd = 0.6;

// Velocidade horizontal (esquerda e direita).
// Começa parado.
hveloc = 0;

// Velocidade vertical (cima e baixo).
// Começa sem subir nem cair.
vveloc = 0;

// Força da gravidade aplicada ao monstro.
gravidade = 0.25;

// Direção inicial:
// -1 = esquerda
//  1 = direita
direct = -1;

// =====================================================
// VIDA DO MONSTRO DE GELO
// =====================================================

// Quantidade de golpes que o boss suporta
vida_monstro_gelo = 20;

// Armazena a vida máxima para uso na barra de vida.
vida_monstro_gelo_max = vida_monstro_gelo;

// Vida falsa para impedir que o sistema do objeto pai
// destrua o boss automaticamente.
vida = 999;

// =====================================================
// TIMERS E COOLDOWNS
// =====================================================

// Tempo que o boss permanece parado após atacar
// 60 frames ≈ 1 segundos em 60 FPS.
tempo_descanso = 60;

// Contador usado durante o descanso.
timer_descanso = 0;

// Tempo mínimo entre ataques.
// 180 frames ≈ 3 segundos.
tempo_ataque = 180;


// Começa parcialmente carregado para dar ao jogador
// alguns segundos para reagir no início da luta.
timer_ataque = 90;

// =====================================================
// MÁQUINA DE ESTADOS
// =====================================================

// Lista de comportamentos possíveis do boss.
enum ESTADO_MONSTRO_GELO{
	
	 // Segue o jogador.
	 PERSEGUINDO,
	 
	  // Fica parado recuperando-se.
	  DESCANSO,
	  
	   // Ataque de soco.
	   SOCAO,
	   
	   // Ataque batendo o pé no chão.
	   PISADA,
	   
	   // Ataque batendo com o braço.
	   BRACADA,
	   
	    // Estado de morte.
		MORTE
}

// Estado inicial do boss.
estado = ESTADO_MONSTRO_GELO.PERSEGUINDO;

// =====================================================
// SPRITES E ANIMAÇÕES
// =====================================================

// Sprite andando para a direita.
spr_andando_direita = spr_monstro_gelo_andando_direita;

// Sprite andando para a esquerda.
spr_andando_esquerda = spr_monstro_gelo_andando_esquerda70;

// Sprite parado.
spr_parado = spr_monstro_gelo;

// Sprite do ataque de soco
spr_socao = spr_monstro_gelo_atacando;

// Sprite do ataque de pisada.
spr_pisada = spr_mostro_gelo_atacando2;

// Sprite do ataque de braçada.
spr_bracada = spr_mostro_gelo_atacando3;

// Sprite usado quando o boss morre.
spr_morte = spr_monstro_gelo_morto;

// Sobrescreve o sprite de morte herdado do objeto pai.
sprite_morrendo = spr_monstro_gelo_morto;

// Começa usando o sprite parado.
sprite_index = spr_parado;

// Define a máscara de colisão inicial
mask_index = spr_parado;

// =====================================================
// EFEITOS VISUAIS E COMBATE
// =====================================================

// Conta há quanto tempo o boss está no estado atual
timer_estado = 0;

// Evita que um mesmo ataque cause dano várias vezes
ja_deu_dano = false;

// Deslocamento vertical usado em animações.
y_offset = 0;

// Intensidade do tremor horizontal da tela
shake_x = 0;

// Raio da onda de choque criada pela pisada
stomp_wave_radius = 0;

// Progresso visual da onda de gelo da braçada
sweep_progress = 0;

// Controla qual será o próximo ataque:
// 0 = Socão
// 1 = Pisada
// 2 = Braçada
proximo_ataque = 0;

// Escala visual horizontal.
// Usada para efeitos de squash and stretch.
scale_x_visual = 1;

// Escala visual vertical.
// Usada para efeitos de squash and stretch.
scale_y_visual = 1;

// Define se o boss está vulnerável a ataques.
// O boss começa invulnerável e só fica vulnerável ao terminar sua sequência de 3 ataques.
vulneravel = false;

