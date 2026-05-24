// Inicializa o tempo da fase 3
// A fase começa com 60 segundos
tempo_fase3 = 60;


// =========================
// VARIÁVEIS DE PAUSA
// =========================

// Define que o jogo inicia sem estar pausado
pausado = false;

// Variável usada para dizer que o jogo deve pausar
// no próximo frame do jogo
pausar_proximo_frame = false;


// Lista com as opções que aparecerão no menu de pausa
opcoes_pause = [
"RETORNAR",        // Volta ao jogo
"SALVAR O JOGO",   // Salva o progresso
"SAIR"             // Sai do jogo
];

// Começa selecionando a primeira opção do menu
// (posição 0 = RETORNAR)
opcao_selecionada = 0;


// Ainda não existe imagem/sprite carregada para a pausa
// -1 normalmente significa "nenhum valor"
pause_sprite = -1;


// =========================
// DADOS DO JOGADOR SALVOS
// =========================

// Variáveis que guardarão informações do jogador
// quando o jogo for pausado

// Quantidade de vidas
vida_pause = 0;

// Quantidade de frutas
frutas_pause = 0;

// Quantidade de facas
faca_pause = 0;

// Número de cargas da faca
faca_cargas_pause = 0;

// Posição X do jogador
player_x_pause = 0;

// Posição Y do jogador
player_y_pause = 0;


// =========================
// MENSAGEM DE SALVAMENTO
// =========================

// Timer usado para controlar quanto tempo
// a mensagem "Salvo com sucesso"
// ficará aparecendo
salvo_mensagem_timer = 0;

