// Inicializa o tempo da fase 3
tempo_fase3 = 60;

//Variáveis de pausa
pausado = false;
// Diz se o jogo deve pausar no próximo frame
pausar_proximo_frame = false;
opcoes_pause = [
"RETORNAR",
"SALVAR O JOGO",
"SAIR"
];
opcao_selecionada = 0;
//Ainda não existe sprite de pausa carregado
pause_sprite = -1;
//o jogador começa sem vidas
vida_pause = 0;
frutas_pause = 0