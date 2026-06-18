/// @description Insert description here
// variáveis de controle do teclado
direita = 0;   // verifica se o jogador está pressionando a tecla para ir para a direita
esquerda = 0;  // verifica se o jogador está pressionando a tecla para ir para a esquerda
cima = 0;      // verifica se o jogador está pressionando a tecla para pular ou subir

// direção para onde o personagem está olhando
direct = 0; // 0 significa direita

// força da gravidade aplicada ao personagem
gravidade = 0.2; // faz o personagem cair lentamente para baixo

// velocidades do personagem
hveloc = 0; // velocidade horizontal (movimento para direita e esquerda)
vveloc = 0; // velocidade vertical (movimento para cima e para baixo)

// velocidade máxima de movimento do personagem
veloc = 1.2;

// -------------------
// SISTEMA DE COMBATE
// -------------------

// Se as variáveis globais ainda não existem, criamos elas com os valores iniciais de forma independente
if (!variable_global_exists("vida_save")){
	
	global.vida_save = 5;
}
// Verifica se já existe a variável global "faca_save"
// Se não existir, cria com valor inicial 0
if (!variable_global_exists("faca_save")){
	global.faca_save = 0;
}

// Verifica se já existe a variável global "faca_cargas_save"
// Se não existir, cria com valor inicial 0
if (!variable_global_exists("faca_cargas_save")){
	global.faca_cargas_save = 0
}

if (!variable_global_exists("frutas_save")){
	global.frutas_save = 0;
}

if (!variable_global_exists("inv_save")){
	global.inv_save = 0;
}





vida = global.vida_save; // Pega a vida que estava guardada na global
faca = global.faca_save;
faca_cargas = global.faca_cargas_save;
frutas = global.frutas_save;


alfa_hit = 0; 
// variável usada para controlar o efeito de piscar quando o personagem toma dano
dano_lava = false; // variável usada para controlar se o personagem está sob efeito de dano da lava


// Inicia o alarme com o tempo que foi salvo ao passar de fase
alarm[0] = global.inv_save; 
// Zera o save para garantir que a invencibilidade não fique salva para sempre se o jogo reiniciar
global.inv_save = 0; 

// o alarm é um temporizador do GameMaker
// Usado para dar um tempo de invencibilidade após levar dano

estado = scr_personagem_movendo;

inv_tempo = 180; //Tempo de invensibilidade do personagem depois de tomar dano

forca_pulo = 3.5; // Força do pulo 
pulos_max = 2;    // O limite de pulos (2 para duplo pulo)
pulos = pulos_max;        // Quantos pulos ele tem disponíveis agora

morreu = false;

// O carregamento da faca já foi feito lá em cima através das globais
// --- SISTEMA DE DANO E PISCAR ---
invencivel = false;              // Diz se o jogador está imune a dano no momento
tempo_invencibilidade = 120;      // Duração do efeito (60 frames = 1 segundo a 60 FPS)
timer_invencibilidade = 0;       // Contador de tempo
atacando = false;
dano_ataque = 1;

// =========================================================================
// CORREÇÃO DE ESTRUTURAS FÍSICAS (FASE 7)
// =========================================================================
if (room == rm_fase7) {
    // 1. Cria a colisão física da ponte superior como plataforma (para poder subir/descer).
    // A ponte original está na altura Y = 216.
    for (var xx = 160; xx < 768; xx += 16) {
        instance_create_depth(xx, 216, depth, obj_plataforma_fase2);
    }
    
    // Converte os blocos de colisão sólida (obj_parede) da ponte colocados no editor
    // para plataformas (obj_plataforma_fase2) para que o jogador possa descer/atravessar.
    with (obj_parede) {
        if (y >= 210 && y <= 220 && x < 185) {
            instance_change(obj_plataforma_fase2, true);
        }
    }
    
    // 2. Cria uma barreira vertical no limite esquerdo da sala (X = 0)
    // Isso impede o jogador de atravessar a parede visual da esquerda e sair do mapa.
    for (var yy = 0; yy <= 216; yy += 16) {
        instance_create_depth(0, yy, depth, obj_parede);
    }
    
    // 3. Cria a colisão física no topo da árvore (X = 224 até X = 512 na altura Y = 72)
    // Isso permite que o jogador fique de pé em cima da árvore se for colocado lá.
    for (var xx = 224; xx < 512; xx += 16) {
        instance_create_depth(xx, 72, depth, obj_parede);
    }
}
