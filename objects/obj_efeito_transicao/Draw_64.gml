var _w = display_get_gui_width();
var _h = display_get_gui_height();

draw_set_alpha(alpha);
draw_set_color(color);
// Desenha um retângulo preenchido cobrindo a tela inteira
// (0,0) = canto superior esquerdo
// (_w,_h) = canto inferior direito
// false = preenchido (não é só contorno)
draw_rectangle(0,0, _w, _h, false);

// Isso é importante para não afetar outros desenhos depois
draw_set_alpha(1);

