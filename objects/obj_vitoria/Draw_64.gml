
draw_set_color(c_black);

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

draw_set_color(c_white);

draw_set_alpha(1);

draw_set_font(fnt_final);

var meio_x = display_get_gui_width() / 2;
var meio_y = display_get_gui_height() / 2;

// ----------------------------
// TEXTOS NA TELA
// ----------------------------

// Desenha o texto principal "END GAME!"
// meio_x = centro horizontal
// meio_y - 120 = um pouco acima do centro
// 2, 2 = aumenta o tamanho do texto
// 0 = sem rotação
draw_text_transformed(meio_x , meio_y - 120, "FIM DE JOGO!", 2, 2 , 0);

// Desenha o nome do criador um pouco abaixo do título
draw_text(meio_x, meio_y - 60, "By Jaysa Kelly");

// Desenha as instruções para o jogador
// meio_y + 120 = abaixo do centro
draw_text(meio_x, meio_y + 120, "Pressione 'R' para Reiniciar ou 'Enter' para o Menu");

// ----------------------------
// RESET DAS CONFIGURAÇÕES
// ----------------------------

draw_set_halign(fa_left);

draw_set_valign(fa_top)
