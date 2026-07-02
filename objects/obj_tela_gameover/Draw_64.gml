/// @description Insert description here
/// @description Insert description here
/// @description Insert description here

// Desenha um fundo preto semi-transparente para destacar o texto
draw_set_color(c_black);
draw_set_alpha(0.75); // 75% de opacidade
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

// Alinha o texto no centro
draw_set_halign(fa_center);
draw_set_valign(fa_center);

// Define a cor branca totalmente opaca e a fonte 
draw_set_color(c_white);
draw_set_alpha(1.0);
draw_set_font(fnt_gameover);

// Pega o meio da tela
var meio_x = display_get_gui_width()/2;
var meio_y = display_get_gui_height()/2;

// Desenha os textos
draw_text_transformed(meio_x, meio_y - 50, "GAME OVER", 2, 2, 0);
draw_text(meio_x, meio_y + 30, "Pressione 'R' para Reiniciar");
draw_text(meio_x, meio_y + 70, "Pressione 'Enter' para voltar ao Menu Principal");

// Reseta o alinhamento e transparência para o padrão do GameMaker
draw_set_halign(fa_left); // Volta o horizontal para a ESQUERDA
draw_set_valign(fa_top);  // Volta o vertical para o TOPO
draw_set_color(c_white);
draw_set_alpha(1.0);







