/// @description Insert description here

// Define a cor de desenho como preta
draw_set_color(c_black);

// Define a transparência em 75% (0 = invisível, 1 = totalmente visível)
draw_set_alpha(0.75);

// Desenha um retângulo preenchido cobrindo toda a tela da interface (GUI)
// Isso cria um fundo preto semi-transparente atrás do texto
draw_rectangle(
		0, // Canto esquerdo (posição X inicial)
		0,// Canto superior (posição Y inicial)
		display_get_gui_width(), // Largura total da tela
		display_get_gui_height(),  // Altura total da tela
		false // Desenha um retângulo preenchido (não apenas a borda)
		);

// Alinha os próximos textos pelo centro na horizontal
draw_set_halign(fa_center);

// Alinha os próximos textos pelo centro na vertical
draw_set_valign(fa_center);

// Muda a cor de desenho para branco
draw_set_color(c_white);

// Deixa os próximos desenhos totalmente visíveis (sem transparência)
draw_set_alpha(1.0);

// Define a fonte que será usada para escrever os textos
draw_set_font(fnt_gameover);

// Cria uma variável com a coordenada X do centro da tela
var meio_x = display_get_gui_width() / 2;

// Cria uma variável com a coordenada Y do centro da tela
var meio_y = display_get_gui_height() / 2;

// Desenha o texto "GAME OVER"
// meio_y - 50 faz o texto aparecer um pouco acima do centro
// 2,2 aumenta o tamanho do texto para o dobro
// 0 significa que o texto não será girado
draw_text_transformed(
		meio_x,
		meio_y - 50,
		"GAME OVER",
		2,
		2,
		0);
			
// Desenha a mensagem para reiniciar o jogo
// meio_y + 30 posiciona o texto abaixo do "GAME OVER"
draw_text(
	meio_x,
	meio_y + 30,
	"Pressione 'R' para Reiniciar"
	);
	
// Desenha a mensagem para voltar ao menu principal
// meio_y + 70 posiciona o texto ainda mais abaixo
draw_text(
	meio_x, 
	meio_y + 70,
	"Pressione 'Enter' para voltar ao Menu Principal"
	);
	
// Restaura o alinhamento horizontal para a esquerda
// Isso evita que outros textos do jogo continuem centralizados
draw_set_halign(fa_left);

// Restaura o alinhamento vertical para o topo
draw_set_valign(fa_top);

// Restaura a cor padrão para branco
draw_set_color(c_white);

// Restaura a transparência para 100%
// Assim, os próximos desenhos não ficarão transparentes
draw_set_alpha(1.0);






