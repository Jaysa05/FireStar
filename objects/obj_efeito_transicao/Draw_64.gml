/// @description Insert description here
// Pega a largura da tela na camada GUI (interface fixa)
var _w = display_get_gui_width();
// Pega a altura da tela na camada GUI
var _h = display_get_gui_height();

// Define a transparência do desenho (usa a variável alpha do fade)
draw_set_alpha(alpha);
// Define a cor do desenho (no meu caso, preto)
draw_set_color(color);
// Desenha um retângulo preenchido cobrindo a tela inteira
// (0,0) = canto superior esquerdo
// (_w,_h) = canto inferior direito
// false = preenchido (não é só contorno)
draw_rectangle(0,0, _w, _h, false);

// Volta o alpha para 1 (totalmente visível)
// Isso é importante para não afetar outros desenhos depois
draw_set_alpha(1);


