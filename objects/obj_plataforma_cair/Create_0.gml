/// @description Insert description here
espera_max = 90;// Tempo parada (90 frames = 1.5 segundos)
limite_y =120;// Quantos pixels ela desce até parar
velocidade = 2;// Velocidade de queda/subida

comecar_embaixo = false;// Variável para inverter o ciclo numa plataforma específica
// Sistema de Estados
// 0 = Cima, 1 = Descendo, 2 = Baixo, 3 = Subindo
estado = 0;
timer = 0;

iniciado = false;// Variável para checar se a sala acabou de iniciar
