// ===============================
// HERANÇA
// ===============================

// Executa o código do objeto "pai" (parente)
// Ou seja: reaproveita coisas que já existem no inimigo base
event_inherited(); 


// ===============================
// FÍSICA (MOVIMENTO)
// ===============================

// Velocidade base do boss (quão rápido ele anda)
spd = 2;       

// Velocidade horizontal (esquerda/direita)
// Começa em 0 = parado
hveloc = 0;       

// Velocidade vertical (cima/baixo)
// Começa em 0 = não está pulando nem caindo ainda
vveloc = 0;       

// Gravidade (faz o boss cair naturalmente)
gravidade = 0.3;

// 1 = Direita, -1 = Esquerda
direcao = 1;


// ===============================
// MÁQUINA DE ESTADOS (COMPORTAMENTO)
// ===============================

// Cria os "modos" que o boss pode ter
enum ESTADO_BOSS {
    PERSEGUINDO, // Vai atrás do jogador
    ESPADA,      // Ataca com espada
    PULO,        // Dá um pulo
    FOGO,        // Ataque de fogo
    DESCANSO,    // Fica parado descansando
    MORTE        // Está morrendo
}

// Define o estado inicial
// Quando o jogo começa, ele já começa perseguindo
estado = ESTADO_BOSS.PERSEGUINDO;


// ===============================
// STATUS DO BOSS
// ===============================

// Vida do boss
// Quando chegar a 0, ele morre
vida_boss = 10;

// Controle de dano
// Serve para não dar dano várias vezes seguidas
deu_dano = false;


// ===============================
// ATAQUES E DISTÂNCIAS
// ===============================

// Distância para ataque de espada (perto)
distancia_espada = 60; 

// Distância para ataque de fogo (mais longe)
distancia_fogo = 150;  

// Tempo entre ataques especiais (em frames)
// 120 frames ≈ 2 segundos
timer_ataques = 120;   

// Timer atual (contador)
// Começa cheio (120) e vai diminuindo
timer_atual = timer_ataques;


// ===============================
// SISTEMA DE DESCANSO
// ===============================

// Tempo que o boss aguenta perseguindo antes de cansar
// 300 frames ≈ 5 segundos
tempo_entre_descansos = 300; 

// Timer que conta esse tempo de perseguição
timer_descanso = tempo_entre_descansos;

// Tempo que ele fica parado descansando
// 120 frames ≈ 2 segundos
duracao_descanso = 120;      

// Timer usado DURANTE o descanso
// Começa em 0 porque ele ainda não está descansando
timer_atual_descanso = 0;


// ===============================
// SPRITES (IMAGENS)
// ===============================

// Sprite padrão (andar/parado)
spr_idle = spr_boss_andando;            

// Sprite de descanso (boss parado)
spr_descanso = spr_boss_parado;        

// Sprite do ataque de espada
spr_espada = spr_boss_atacando_espada; 

// Sprite do ataque de fogo
spr_fogo = spr_boss_soltando_fogo;   

// Sprite de pulo (no ar)
spr_pulo = pulos;                 

// Sprite de morte
spr_morte = spr_boss_morrendo; 