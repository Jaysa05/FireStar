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

// Define a fonte que será usada nos textos
draw_set_font(fnt_final);

// Calcula o centro da tela (horizontal e vertical)
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

// Volta o alinhamento horizontal para o padrão (esquerda)
draw_set_halign(fa_left);

// Volta o alinhamento vertical para o padrão (topo)
draw_set_valign(fa_top)
