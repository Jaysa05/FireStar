// pega a largura do sprite de vida e multiplica por 2
// isso acontece porque o sprite será desenhado em escala 2
// então precisamos saber o tamanho real que ele terá na tela
var _sprl = sprite_get_width(spr_vida) * 2;


// espaço entre um coração e outro
// quanto maior esse número, maior o espaço entre as vidas
var _buffer = 20;


// pega quantas vidas o personagem tem
// essa variável vem do objeto do personagem
var _vidas = obj_personagem.vida;


// loop que vai repetir o desenho do coração várias vezes
// ele começa em 0 e repete até chegar na quantidade de vidas
for (var i = 0; i < _vidas; i++){

	// desenha o sprite da vida na tela
	draw_sprite_ext(
	
		spr_vida, // sprite que será desenhado
	
		0, // subimagem do sprite (frame da animação)
	
		// posição X onde o coração será desenhado
		// 20 = distância da borda da tela
		// (_sprl * i) = move cada coração pelo tamanho do sprite
		// (_buffer * i) = adiciona espaço entre os corações
		20 + (_sprl * i) + (_buffer * i),
	
		20, // posição Y na tela
	
		2,2, // escala do sprite (2x maior)
	
		0, // rotação do sprite
	
		c_white, // cor do sprite
	
		1 // transparência (1 = totalmente visível)
	);
}

// === CONTADOR DE FRUTAS ===
// Calcula a posição horizontal (X) onde a fruta vai aparecer
// 20 = margem da esquerda
// (_sprl + _buffer) * _vidas = espaço ocupado pelos corações
// +30 = espaço extra depois dos corações
var _x_fruta = 20 + (_sprl + _buffer) *_vidas + 30;

// Cria uma "linha guia" vertical baseada nos corações
// 20 = margem do topo
// sprite_get_height(spr_vida) = altura do coração
// Isso ajuda a alinhar tudo (fruta + texto)
var _centro_guia = 20 + sprite_get_height(spr_vida);

// Verifica se a sprite da fruta existe (evita erro)
if (sprite_exists(spr_fruta)){
	// Define o tamanho da fruta (escala)
    // 1 = normal | 2 = dobro | 3 = triplo
	var _escala_fruta = 3;
	
	// ================= AJUSTES MANUAIS =================
    // Esses valores servem para "empurrar" a fruta e o texto
    // sem mexer na lógica principal

    // Ajuste da fruta no eixo X (horizontal)
    // positivo → direita | negativo → esquerda
	var _ajuste_fruta_x = 0;
	
	// Ajuste da fruta no eixo Y (vertical)
    // positivo → desce | negativo → sobe
	var _ajuste_fruta_y = -4;
	
	// Ajuste do texto no eixo X
	var _ajuste_texto_x = 0;
	
	// Ajuste do texto no eixo Y
	var _ajuste_texto_y = 7;
	
	// Calcula a posição Y da fruta para deixá-la centralizada
    // Explicação:
    // - pega o centro (_centro_guia)
    // - subtrai metade da altura da fruta (já com escala)
    // - aplica ajuste manual (_ajuste_fruta_y)
	var _y_fruta_alinhada = _centro_guia - ((sprite_get_height(spr_fruta) * _escala_fruta) / 2) + _ajuste_fruta_y;
	
	// Calcula posição final X da fruta com ajuste manual
	var _x_final_fruta = _x_fruta + _ajuste_fruta_x;
	
	// Desenha a fruta na tela
    // parâmetros:
	// sprite, frame, x, y, escalaX, escalaY, rotação, cor, opacidade
	draw_sprite_ext(spr_fruta, 0 , _x_final_fruta, _y_fruta_alinhada, _escala_fruta, _escala_fruta, 0 , c_white, 1);
	
	 // Define a fonte do texto (fonte personalizada do projeto)
	 draw_set_font(fnt_menu);
	 
	 // Alinhamento horizontal do texto (começa da esquerda)
	 draw_set_halign(fa_left);
	 
	 // Alinhamento vertical do texto (centralizado)
	 draw_set_valign(fa_middle);
	 
	 // Desenha o texto da quantidade de frutas
	 draw_text_transformed(
	  // Posição X do texto:
        // começa na fruta +
        // largura da fruta (já escalada) +
        // espaço de 10 pixels +
        // ajuste manual
		_x_final_fruta + (sprite_get_width(spr_fruta) * _escala_fruta) + 10 + _ajuste_texto_x,
		// Posição Y do texto:
        // usa o centro guia +
        // ajuste manual vertical
		_centro_guia + _ajuste_texto_y,
		 // Texto exibido:
        // "x" + número de frutas do personagem
		 "x" + string(obj_personagem.frutas),
		// Escala do texto
		0.7, 0.7,
		// Rotação (0 = normal)
		0
		);
		
		// Reseta alinhamento vertical para padrão (evita bugs em outros textos)
		draw_set_valign(fa_top);
		
		// Reseta a fonte para padrão do GameMaker
    // Isso é MUITO importante pra não afetar outros desenhos
	draw_set_font(-1);
		
}



// Só executa esse código se estiver na fase 3
if ( room == rm_fase3){
	 // Arredonda o tempo para cima (ex: 9.2 vira 10)
	 var _tempo_arredondado = ceil(tempo_fase);
	 
	 // Pega o centro horizontal da tela (GUI)
	 var _meio_tela = display_get_gui_width()/2;
	 
	  // Texto fixo "Tempo: "
	  var _texto_palavra = "Tempo: ";
	  
	  // Converte o número do tempo para texto
	  var _texto_numero = string(_tempo_arredondado);
	  
	  // Mede a largura do texto "Tempo: " e multiplica por 2 (por causa da escala)
	  var _largura_palavra = string_width(_texto_palavra)* 2;
	  
	  // Mede a largura do número e multiplica por 2 (por causa da escala
	  var _largura_numero = string_width(_texto_numero)*2;
	  
	  // Soma as duas larguras para saber o tamanho total da frase
	  var _largura_total = _largura_palavra + _largura_numero;
	  
	  // Calcula onde o texto deve começar para ficar centralizado na tela
	  var _x_inicial = _meio_tela - (_largura_total);
	  
	  // Define o alinhamento do texto para começar da esquerda
	  draw_set_halign(fa_left);
	  
	  // Define a cor branca para desenhar "Tempo: "
	  draw_set_color(c_white);
	  
	  // Desenha o texto "Tempo: " na tela com escala 2x
	  draw_text_transformed(_x_inicial, 30, _texto_palavra, 2,2, 0)
	  
	  // Se o tempo for menor ou igual a 10
	  if(_tempo_arredondado <= 10){
		  // Muda a cor para vermelho (alerta)
		  draw_set_color(c_red);
	  }else{
		   // Caso contrário, mantém branco
		   draw_set_color(c_white);
	  }
	  // Desenha o número logo após "Tempo: ", mantendo alinhado
	  draw_text_transformed(_x_inicial + _largura_palavra, 30, _texto_numero, 2, 2, 0);
    
    // Reseta a cor para branco (evita afetar outros desenhos do jogo)
    draw_set_color(c_white);
}



