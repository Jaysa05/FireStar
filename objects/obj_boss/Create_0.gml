event_inherited(); 
// Chama o código do evento pai (caso esse objeto herde de outro)

// ==============================
// FÍSICA E MOVIMENTO
// ==============================

spd = 1.5; 
// Velocidade base do boss

distancia_parar = 50; 
// Distância mínima para parar perto do jogador

hveloc = 0;
// Velocidade horizontal inicial

vveloc = 0;
// Velocidade vertical inicial

gravidade = 0.3;
// Valor da gravidade aplicada ao boss

direct = 1; 
// Direção (1 = direita, -1 = esquerda)

item_drop = noone;
// Item que o boss pode dropar ao morrer (inicialmente nenhum)


// ==============================
// VIDA
// ==============================

vida_boss = 10;
// Vida real do boss (quantos hits ele aguenta)


// ==============================
// SISTEMA DE TEMPO (TIMERS)
// ==============================

tempo_perseguindo = 600;     
// Tempo total que o boss fica perseguindo (em steps)

timer_perseguicao = tempo_perseguindo; 
// Contador que vai diminuindo durante a perseguição

tempo_descanso = 300;        
// Tempo que o boss fica parado descansando (5 segundos se room_speed = 60)

timer_descanso = 0;          
// Contador do tempo de descanso

tempo_ataque = 120;
// Cooldown entre ataques (em frames)

timer_ataque = tempo_ataque;
// Contador para o cooldown de ataque (começa cheio para não atacar de imediato)




// ==============================
// MÁQUINA DE ESTADOS
// ==============================

enum ESTADO_BOSS {
    PERSEGUINDO, // Boss vai atrás do jogador
    DESCANSO,    // Boss fica parado
    ESPADA,      // Ataque com espada
    FOGO,        // Ataque de fogo
    MORTE        // Estado de morte
}

estado = ESTADO_BOSS.PERSEGUINDO;
// Estado inicial do boss (começa perseguindo)


// ==============================
// SPRITES
// ==============================

spr_andando = spr_boss_andando;
// Sprite usado quando o boss está andando

spr_parado = spr_boss_parado; 
// Sprite usado quando o boss está parado

spr_morte = spr_boss_morrendo;
// Sprite usado quando o boss está morrendo

spr_ataque = spr_boss_atacando_espada;
// Sprite usado no ataque de espada

mask_index = spr_parado;
// Mantém a caixa de colisão sempre igual para evitar prender em paredes




// ==============================
// VIDA "FAKE"
// ==============================

vida = 999; 
// Vida falsa para impedir que o sistema padrão (do objeto pai)
// mate o boss automaticamente
// O controle real da vida está em "vida_boss"