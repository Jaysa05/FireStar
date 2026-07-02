
// 1. Caso a variável "target" tenha sido definida e o objeto alvo exista:
if (variable_instance_exists(id, "target") && instance_exists(target)) {
	
	// Define a largura da barra para 100% do tamanho original (tamanho completo do sprite).
	var escala_largura = 1.0;
	
	// Calcula o centro horizontal do chefe.
	var centro_x = (target.bbox_left + target.bbox_right) / 2;
	
	// Corrige o desalinhamento visual do Minotauro quando ele está virado para a esquerda (direct == -1)
	if (target.object_index == obj_minotauro) {
		if (target.direct == -1) {
			centro_x -= 21;
		}
	}
	
	// Calcula a largura máxima da barra considerando a escala definida.
	var largura_maxima = sprite_get_width(sprite_index) * escala_largura;
	
	// Posiciona a barra centralizada sobre o chefe.
	x = centro_x - (largura_maxima / 2);
	
	// Coloca a barra um pouco acima da cabeça do chefe.
	y = target.bbox_top - 20;
	
	// Garante que a barra seja desenhada na frente do chefe
	depth = target.depth - 100;
	
	// Define a vida máxima baseado no tipo de inimigo.
	var _vida_max = 8.0; // Padrão (Ex: Demônio)
	if (target.object_index == obj_minotauro) {
		_vida_max = 15.0; // Vida máxima do Minotauro
	}
	
	// Atualiza o comprimento da barra.
	image_xscale = max(0, (target.vida / _vida_max) * escala_largura);
	image_yscale = 1.0;
}
// 2. Compatibilidade retrô: Caso o "target" não tenha sido definido, mas o demônio clássico exista:
else if (instance_exists(obj_demonio)) {
	
	var escala_largura = 1.0;
	var centro_demonio_x = (obj_demonio.bbox_left + obj_demonio.bbox_right) / 2;
	var largura_maxima = sprite_get_width(sprite_index) * escala_largura;
	
	x = centro_demonio_x - (largura_maxima / 2);
	y = obj_demonio.bbox_top - 20;
	
	depth = obj_demonio.depth - 100;
	
	image_xscale = max(0, (obj_demonio.vida / 8.0) * escala_largura);
	image_yscale = 1.0;
}
// 3. Se não houver nenhum chefe ativo, destrói a barra.
else {
	instance_destroy();
}