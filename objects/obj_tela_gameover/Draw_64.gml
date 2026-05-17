
// Alinha o texto no centro
draw_set_halign(fa_center);
draw_set_valign(fa_center);

draw_set_color(c_white);
draw_set_font(fnt_gameover);

var meio_x = display_get_gui_width()/2;
var meio_y = display_get_gui_height()/2;

// Desenha os textos
draw_text_transformed(meio_x, meio_y - 50, "GAME OVER",2,2,0);
draw_text(meio_x, meio_y + 30, "Pressione 'R' para Reiniciar");
draw_text(meio_x, meio_y + 70, "Pressione 'Enter' para voltar ao Menu Principal");

draw_set_halign(fa_left);
draw_set_valign(fa_top);

