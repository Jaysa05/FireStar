event_inherited(); 
// Chama o código do evento pai (caso esse objeto herde de outro)

// ==============================
// SISTEMA DE ALEATORIEDADE
// ==============================
randomize(); 
// IMPORTANTE: Isso obriga o GameMaker a gerar uma semente ("seed") aleatória nova toda vez que você abrir o jogo.
// Sem isso, o GameMaker usa SEMPRE a mesma sequência de números para facilitar os testes, o que faz os ataques parecerem scriptados!

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

tempo_descanso = 240;        
// Tempo que o boss fica parado descansando (4 segundos se room_speed = 60)

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
    PERSEGUINDO, 
    DESCANSO,    
    ESPADA,      
    PULO,        
    FEITICO,     
    MORTE        
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

spr_pulo = spr_boss_pulando;
// Sprite do ataque de pulo em área

mask_index = spr_parado;
// Mantém a caixa de colisão sempre igual para evitar prender em paredes




// ==============================
// VIDA "FAKE"
// ==============================

vida = 999; 
// Vida falsa para impedir que o sistema padrão (do objeto pai)
// mate o boss automaticamente
// O controle real da vida está em "vida_boss"

pulo_fase = 0;
// Fase do ataque de pulo (0 = parado, 1 = subindo, 2 = no ar, 3 = pousou)

ja_deu_dano = false;
// Variável para garantir que o dano do pulo só ocorra uma vez por impacto

// Controle do ataque de pulo
ja_deu_dano = false;
