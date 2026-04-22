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

// Se as variáveis globais ainda não existem, criamos elas com os valores iniciais
if (!variable_global_exists("vida_save")) {
    global.vida_save = 5;
    global.faca_save = 0;
    global.faca_cargas_save = 0;
	global.frutas_save = 0;
}


vida = global.vida_save; // Pega a vida que estava guardada na global
faca = global.faca_save;
faca_cargas = global.faca_cargas_save;
frutas = global.frutas_save;


alfa_hit = 0; 
// variável usada para controlar o efeito de piscar quando o personagem toma dano

alarm[0] = 0; 
// inicia o alarme 0 em 0
// o alarm é um temporizador do GameMaker
// Usado para dar um tempo de invencibilidade após levar dano

estado = scr_personagem_movendo;

inv_tempo = 180; //Tempo de invensibilidade do personagem depois de tomar dano

forca_pulo = 3.5; // Força do pulo 
pulos = 0;        // Quantos pulos ele tem disponíveis agora
pulos_max = 2;    // O limite de pulos (2 para duplo pulo)

morreu = false;

// O carregamento da faca já foi feito lá em cima através das globais

