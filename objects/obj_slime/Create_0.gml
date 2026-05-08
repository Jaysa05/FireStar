/// @description Insert description here

// Herda as variáveis do objeto pai (incluindo "vida")
// DEVE vir primeiro, antes de qualquer leitura de variável
event_inherited(); 

item_drop = noone; // Continua sem dropar itens 

// Guarda a posição inicial do slime (onde ele nasceu no mapa)
ponto_de_partida = x;

// Define a velocidade do slime (0.5 = bem devagar)
velocidade_slime = 0.5;

// Tempo que o slime vai ficar invisível (10 segundos)
tempo_invisivel = room_speed * 10;

// Contador de tempo para reaparecer
timer_slime = 0;

// Define se o slime começa visível ou não
estado_visivel = true;

