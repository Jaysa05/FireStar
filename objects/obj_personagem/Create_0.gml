// variáveis de controle do teclado
direita = 0;   // verifica se o jogador está pressionando a tecla para ir para a direita
esquerda = 0;  // verifica se o jogador está pressionando a tecla para ir para a esquerda
cima = 0;      // verifica se o jogador está pressionando a tecla para pular ou subir

// direção para onde o personagem está olhando
direct = 0;

// força da gravidade aplicada ao personagem
gravidade = 0.2;

// velocidades do personagem
hveloc = 0;
vveloc = 0;

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
	global.inv_save = 0;
}

vida = global.vida_save;
faca = global.faca_save;
faca_cargas = global.faca_cargas_save;
frutas = global.frutas_save;

alfa_hit = 0; 
// variável usada para controlar o efeito de piscar quando o personagem toma dano

alarm[0] = global.inv_save; 
// Zera o save para garantir que a invencibilidade não fique salva para sempre se o jogo reiniciar
global.inv_save = 0; 

// o alarm é um temporizador do GameMaker
// Usado para dar um tempo de invencibilidade após levar dano

estado = scr_personagem_movendo;

inv_tempo = 180;

forca_pulo = 3.5;
pulos = 0;
pulos_max = 2;

morreu = false;

// O carregamento da faca já foi feito lá em cima através das globais
