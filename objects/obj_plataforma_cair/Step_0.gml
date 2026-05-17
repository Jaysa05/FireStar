if (!iniciado) {
	
	if (comecar_embaixo == true) {
		estado = 2;
		y = ystart + limite_y;
	} else {
		estado = 0;
		y = ystart;
	}
	
	iniciado = true;
}

// Variável que guarda quanto a plataforma vai se mover neste frame
var _move_y = 0;

// Máquina de estados para definir o movimento (_move_y)
switch (estado) {

	case 0:
		
		timer++;
		
		if (timer >= espera_max){
			timer = 0;
			estado = 1;
		}
	break;
	
	case 1:
		
		_move_y = velocidade;
		
		if (y + _move_y >= ystart + limite_y){
			
			// Ajusta o movimento para parar exatamente no limite
			_move_y = (ystart + limite_y) - y;
			
			estado = 2;
			timer = 0;
		}
	break;
	
	case 2:
		
		timer++;
		
		if (timer >= espera_max){
			timer = 0;
			estado = 3;
		}
	break;
	
	case 3:
		
		_move_y = -velocidade;
		
		if (y + _move_y <= ystart){
			
			// Ajusta para parar exatamente no topo
			_move_y = ystart - y;
			
			estado = 0;
			timer = 0;
		}
	break;
}

// ------------------------------
// MOVIMENTAÇÃO DO PERSONAGEM JUNTO COM A PLATAFORMA
// ------------------------------

// (usa y - 1 para checar um pouquinho acima da plataforma)
// 2 pixels acima da plataforma
// x       = posição horizontal atual
// y - 2   = 2 pixels acima
// Isso normalmente é usado para verificar
if ( place_meeting(x, y - 2, obj_personagem)){

	// Só move o personagem junto com a plataforma
	// se ele NÃO estiver pulando para cima.
	
    // vveloc = velocidade vertical do personagem
    // vveloc < 0  -> personagem subindo
    // vveloc = 0  -> personagem parado
    // vveloc > 0  -> personagem caindo
    // >= 0 significa:
    // "caindo ou parado"
	if ( obj_personagem.vveloc >= 0) {
		with(obj_personagem){
			
            // ao ser movido junto com a plataforma
			if (!place_meeting(x, y + _move_y, obj_parede)){
				
                // _move_y é o quanto a plataforma está se movendo
				y += _move_y;
			}
		}
	}
}
// ------------------------------
// MOVIMENTO DA PRÓPRIA PLATAFORMA
// ------------------------------

y += _move_y;