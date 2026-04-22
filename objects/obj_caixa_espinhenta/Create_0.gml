// Guarda a posição inicial da plataforma (onde ela começou no mapa)
y_inicial = y;

// Define a velocidade vertical como 0 (não está subindo nem descendo)
vveloc = 0;

// Define a força da gravidade (quanto mais alto, mais rápido ela acelera ao cair)
gravidade = 0.5;

// Define o estado atual da plataforma
// "esperando" = parada no topo antes de começar a cair
// Outros estados possíveis:
// "caindo" = descendo
// "esperando_chao" = parada embaixo
// "voltando" = subindo de volta
// "esperando_topo" = pausa no topo antes de repetir
estado = "esperando";

// Define um temporizador (alarm[1])
// 60 frames ≈ 1 segundo (se o jogo estiver a 60 FPS)
// Após esse tempo, o código do Alarm[1] será executado
// Geralmente usado para mudar o estado (ex: começar a cair)
alarm[1] = 60;