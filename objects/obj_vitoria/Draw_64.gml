/// @description Desenha a tela de vitória
// Define a cor de desenho como preto
draw_set_color(c_black);

// Define a transparência como totalmente visível
draw_set_alpha(1);

// Desenha um retângulo cobrindo toda a tela (fundo preto)
// (0,0) = canto superior esquerdo
// display_get_gui_width() = largura da tela
// display_get_gui_height() = altura da tela
// false = retângulo preenchido
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

// ----------------------------
// CONFIGURAÇÃO DO TEXTO
// ----------------------------

// Alinha o texto horizontalmente no centro
draw_set_halign(fa_center);

// Alinha o texto verticalmente no centro
draw_set_valign(fa_center);

// Define a cor do texto como branco
draw_set_color(c_white);

// Define a transparência do texto como totalmente visível
draw_set_alpha(1);

// Escolhe a fonte que será usada para desenhar o título.
draw_set_font(fnt_titulo);

// Cria uma variável chamada "meio_x".
// Ela guarda o valor da metade da largura da tela,
// ou seja, o centro horizontal.
var meio_x = display_get_gui_width() / 2;

// Cria uma variável chamada "meio_y".
// Ela guarda o valor da metade da altura da tela,
// ou seja, o centro vertical.
var meio_y = display_get_gui_height() / 2;

// ----------------------------
// DESENHA O TÍTULO
// ----------------------------

// Escreve "The End" usando a fonte do título.
// O texto fica centralizado na horizontal
// e 100 pixels acima do centro da tela.
draw_text(meio_x, meio_y - 100, "The End");

// ----------------------------
// DESENHA O NOME DO CRIADOR
// ----------------------------

// Troca para a fonte usada no menu.
draw_set_font(fnt_menu);

// Escreve o nome do criador.
// O texto fica centralizado e apenas 20 pixels acima do centro.
draw_text(meio_x, meio_y - 20, "Feito por Jaysa Kelly");

// ----------------------------
// DESENHA AS INSTRUÇÕES
// ----------------------------

// Troca para a fonte das instruções finais.
draw_set_font(fnt_final);

// Escreve as instruções para o jogador.
// O texto fica centralizado e 120 pixels abaixo do centro.
draw_text(meio_x, meio_y + 120, "Pressione 'R' para Reiniciar ou 'Enter' para o Menu");


// ----------------------------
// RESET DAS CONFIGURAÇÕES
// ----------------------------

// Volta o alinhamento horizontal para o padrão (esquerda)
draw_set_halign(fa_left);

// Volta o alinhamento vertical para o padrão (topo)
draw_set_valign(fa_top)
