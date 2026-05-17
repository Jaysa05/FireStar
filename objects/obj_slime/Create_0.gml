
// Herda as variáveis do objeto pai (incluindo "vida")
// DEVE vir primeiro, antes de qualquer leitura de variável
event_inherited(); 

item_drop = noone;

ponto_de_partida = x;

velocidade_slime = 0.5;

// Tempo que o slime vai ficar invisível (10 segundos)
tempo_invisivel = room_speed * 10;

// Contador de tempo para reaparecer
timer_slime = 0;

estado_visivel = true;

