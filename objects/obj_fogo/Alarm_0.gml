/// @description Insert description here
// 1. Verifica se o personagem existe na sala para evitar erros de leitura
if (instance_exists(obj_personagem)){
	
	 // Cria uma bola de fogo na mesma posição
    // e na mesma layer do demônio
	var _fogo = instance_create_layer(x, y, layer, obj_fogo);
	
	 // Calcula a direção do demônio
    // até a posição do jogador
	var _direcao = point_direction(x, y , obj_personagem.x, obj_personagem.y);
	
	// Define a direção da bola de fogo
	_fogo.direction = _direcao;
	
	 // Define a velocidade da bola de fogo
	 _fogo.speed = 5;
	 
	  // Gira o sprite do fogo para olhar
    // para a direção em que ele está indo
	_fogo.image_angle = _direcao;
	
}

// Reinicia o alarme
// O inimigo irá atacar novamente
// após o tempo definido em tempo_ataque
alarm[0] = tempo_ataque;

