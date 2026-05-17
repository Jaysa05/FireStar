y_inicial = y;

vveloc = 0;

gravidade = 0.5;

// "esperando" = parada no topo antes de começar a cair
// Outros estados possíveis:
// "caindo" = descendo
// "esperando_chao" = parada embaixo
// "voltando" = subindo de volta
// "esperando_topo" = pausa no topo antes de repetir
estado = "esperando";

// 60 frames ≈ 1 segundo (se o jogo estiver a 60 FPS)
// Após esse tempo, o código do Alarm[1] será executado
// Geralmente usado para mudar o estado (ex: começar a cair)
alarm[1] = 60;