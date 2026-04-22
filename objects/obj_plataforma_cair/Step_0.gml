// Executa apenas uma vez no início para definir o ponto de partida
if (!iniciado) { // Se ainda NÃO foi iniciado
	
	if (comecar_embaixo == true) { // Se a plataforma deve começar embaixo
		estado = 2; // Define o estado como "parado embaixo"
		y = ystart + limite_y; // Coloca a plataforma na posição mais baixa
	} else {
		estado = 0; // Define o estado como "parado em cima"
		y = ystart; // Coloca a plataforma na posição inicial (em cima)
	}
	
	iniciado = true; // Marca que já inicializou (isso evita repetir esse bloco)
}

// Variável que guarda quanto a plataforma vai se mover neste frame
var _move_y = 0;

// Máquina de estados para definir o movimento (_move_y)
switch (estado) {

	case 0: // Estado 0 = Parada em cima
		
		timer++; // Aumenta o contador de tempo
		
		// Quando atingir o tempo máximo de espera
		if (timer >= espera_max){
			timer = 0; // Reseta o contador
			estado = 1; // Muda para o estado "descendo"
		}
	break;
	
	case 1: // Estado 1 = Descendo
		
		_move_y = velocidade; // Define o movimento para baixo
		
		// Se a plataforma for passar do limite inferior
		if (y + _move_y >= ystart + limite_y){
			
			// Ajusta o movimento para parar exatamente no limite
			_move_y = (ystart + limite_y) - y;
			
			estado = 2; // Muda para "parado embaixo"
			timer = 0; // Reseta o tempo
		}
	break;
	
	case 2: // Estado 2 = Parado embaixo
		
		timer++; // Conta o tempo
		
		// Quando atingir o tempo máximo
		if (timer >= espera_max){
			timer = 0; // Reseta o contador
			estado = 3; // Começa a subir
		}
	break;
	
	case 3: // Estado 3 = Subindo
		
		_move_y = -velocidade; // Movimento para cima (negativo)
		
		// Se a plataforma for passar do limite superior
		if (y + _move_y <= ystart){
			
			// Ajusta para parar exatamente no topo
			_move_y = ystart - y;
			
			estado = 0; // Volta para "parado em cima"
			timer = 0; // Reseta o tempo
		}
	break;
}

// ------------------------------
// MOVIMENTAÇÃO DO PERSONAGEM JUNTO COM A PLATAFORMA
// ------------------------------

// Verifica se existe um personagem logo em cima da plataforma
if (place_meeting(x, y - 1, obj_personagem)) {
	
	// Executa código dentro do objeto personagem
	with (obj_personagem) {
		
		// Verifica se o personagem NÃO vai bater em uma parede ao se mover
		if (!place_meeting(x, y + _move_y, obj_parede)) {
			
			y += _move_y; // Move o personagem junto com a plataforma
		}
	}
}

// Aplica o movimento na própria plataforma
y += _move_y;