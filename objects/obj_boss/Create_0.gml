event_inherited(); 

// Física e Distâncias
spd = 1.5; 
distancia_parar = 50; 
hveloc = 0;
vveloc = 0;
gravidade = 0.3;
direct = 1; 
item_drop = noone;

// Vida
vida_boss = 10;

// SISTEMA DE TEMPO (Timers)
tempo_perseguindo = 600;     // Tempo que ele fica te caçando
timer_perseguicao = tempo_perseguindo; // Contador da perseguição

tempo_descanso = 180;        // Tempo que ele fica parado (4 segundos)
timer_descanso = 0;          // Contador do descanso

// Máquina de Estados
enum ESTADO_BOSS {
    PERSEGUINDO,
    DESCANSO,
    ESPADA,
    FOGO,
    MORTE
}
estado = ESTADO_BOSS.PERSEGUINDO;

// Sprites
spr_andando = spr_boss_andando;
spr_parado = spr_boss_parado; 
spr_morte = spr_boss_morrendo;

vida = 999; // Vida "falsa" para o pai não matar o boss