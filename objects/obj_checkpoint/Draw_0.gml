/// @description Insert description here
// -------- DESENHAR O SPRITE --------

// Se o checkpoint ainda NÃO foi ativado
if (!ativado){
	// Desenha o sprite normal do objeto
	draw_self()
}

// -------- MOSTRAR TEXTO "CHECKPOINT" --------
// Se o timer ainda está ativo (ou seja, ainda tem tempo > 0)
if (timer_texto > 0) {
	 // Cria uma variável chamada _alpha (transparência)
    // Começa totalmente visível (1 = opaco)
	var _alpha = 1;
	
	 // -------- EFEITO DE FADE (SUMIR AOS POUCOS) --------
	 // Se faltam menos de 60 frames (último 1 segundo)
	 if (timer_texto < 60 ){
		 
		 // Vai diminuindo a transparência aos poucos
        // Ex: 60 → 1 | 30 → 0.5 | 0 → 0
		_alpha = timer_texto / 60;
	 }
	 
	 // Aplica a transparência no desenho
	 draw_set_alpha(_alpha);
	 
	 // Define a fonte do texto
	 draw_set_font(fnt_checkpoint);
	 
	 // Alinhamento horizontal: centro
	 draw_set_halign(fa_center);
	 
	 // Alinhamento vertical: parte de baixo
	 draw_set_valign(fa_bottom);
	 
	 // Desenha o texto "CheckPoint"
    // x = posição horizontal do objeto
    // y - 32 = um pouco acima do objeto
	draw_text(x, y - 32, "CheckPoint");
	
	// -------- RESETAR CONFIGURAÇÕES --------
	// Volta a transparência ao normal (importante!)
	draw_set_alpha(1);
	
	 // Garante cor branca padrão
	 draw_set_color(c_white);
	 
	 // Volta alinhamento padrão horizontal
	 draw_set_halign(fa_left);
	 
	 // Volta alinhamento padrão vertical
	 draw_set_valign(fa_top);
}
