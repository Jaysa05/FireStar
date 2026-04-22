/// @description Menu principal com seleção de opções

// -----------------------------
// Desenhar o menu na tela
// -----------------------------

var dist = 55;
var gui_largura = display_get_gui_width();
var gui_altura = display_get_gui_height();

var x1 = gui_largura/2;
var y1 = gui_altura/ 2

for (var i = 0; i < op_max; i++){  // Loop para percorrer todas as opções

    // Centraliza o texto horizontal e verticalmente
    draw_set_halign(fa_center);  // Alinhamento horizontal central
    draw_set_valign(fa_center);  // Alinhamento vertical central
	
	// Define a fonte do título
	draw_set_font(fnt_titulo);
	// Define a cor do título
	draw_set_color(c_orange);
	//Desenhando o Título
	draw_text(x1, y1 - 150, "Fire Star");
	
	// -----------------------------
// 2. Desenhar o menu na tela
// -----------------------------
	draw_set_font(fnt_menu);

    // Destaca a opção selecionada
    if(index == i){
        draw_set_color(c_yellow);  // A opção selecionada fica amarela
    } else {
        draw_set_color(c_white);   // As opções não selecionadas ficam brancas
    }
	


    // Desenha o texto da opção na tela
    // x1 → posição horizontal
    // y1 + (dist*i) → posição vertical, espaçando as opções uma abaixo da outra
    // opcoes[i] → o texto que será desenhado
    draw_text(x1, y1 + (dist*i), opcoes[i]);
}

// -----------------------------
// Resetar fonte para a padrão do GameMaker
// -----------------------------
draw_set_font(-1);