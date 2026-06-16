
// Verifica se o demônio ainda existe na sala.
// Isso evita erros caso ele já tenha morrido.
if (instance_exists(obj_demonio)){
	
	// Define a largura da barra para 60% do tamanho original.
	var escala_largura = 0.6;
	
	 // Calcula o centro horizontal do demônio usando a bounding box (mais preciso).
	var centro_demonio_x = (obj_demonio.bbox_left + obj_demonio.bbox_right) / 2;
	
	 
    // Calcula a largura máxima da barra considerando a escala definida.
	var largura_maxima = sprite_get_width(sprite_index) * escala_largura;
	
	// Posiciona a barra centralizada sobre o demônio
	x = centro_demonio_x - (largura_maxima/2);
	
	// Coloca a barra um pouco acima da cabeça do demônio.
	y = obj_demonio.bbox_top -20;
	
	// Atualiza o comprimento da barra de acordo com a vida atual do chefe.
    // Vida máxima = 8.
    // O max(0, ...) impede valores negativos.
	image_xscale = max( 0, (obj_demonio.vida/ 8.0) * escala_largura);
	
	// Mantém a altura original da barra.
	image_yscale = 1.0;
}
else {
	// Se o demônio não existir mais (foi derrotado),
    // destrói a barra de vida.
	instance_destroy();
}