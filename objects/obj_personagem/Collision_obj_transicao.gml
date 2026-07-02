/// @description Transição de Sala Suave

// Salva a vida atual do jogador em uma variável global
global.vida_save = vida;

// Salva se o jogador tem facas 
global.faca_save = faca;

// Salva as cargas/munições/energia da faca
global.faca_cargas_save = faca_cargas;

// Salva o tempo restante de invencibilidade
// max(0, alarm[0]) impede que o valor fique negativo
global.inv_save = max(0, alarm[0]);

// Verifica se o chefe ainda está na fase
// Se sim, a transição fica trancada e o jogador não consegue passar
if (instance_exists(obj_boss) || instance_exists(obj_boss2)) {
    exit;
}

// Verifica se já existe um objeto de transição na sala
// Se existir, o código para aqui para evitar duas transições ao mesmo tempo
if ( instance_exists(obj_efeito_transicao)) exit;

// Cria uma variável local chamada _target
// Ela vai guardar qual será a próxima sala
var _target = noone;

// Se a sala atual for a fase 1
if ( room == rm_fase1)

 // Define a próxima sala como fase 2
 _target = rm_fase2;
 
 // Senão, se estiver na fase 2
 else if (room == rm_fase2)
 
 // Define a próxima sala como fase 3
 _target = rm_fase3;
 
 // Senão, se estiver na fase 3
 else if (room == rm_fase3)
 
  // Define a próxima sala como fase 4
  _target = rm_fase4;
  
  // Caso não seja nenhuma das salas acima, verifica a fase 5
  else if (room == rm_fase5){
	  
	   // Verifica se o jogador está usando a porta de cima.
		// Como essa porta fica próxima ao topo da sala,
		// sua coordenada Y é menor que 100.
		if (other.y < 100) {
			 // Define a Fase 6 como destino.
			 _target = rm_fase6;
		}
		
		// Caso contrário, é a porta da direita.
		else {
			
			// Verifica se NÃO existe mais nenhum demônio na sala.
			// Isso significa que o chefe foi derrotado.
			if (!instance_exists(obj_demonio)){
				
				 // Libera o acesso para a Fase 7
				 _target = rm_fase7;
			}
			
			 // O demônio ainda está vivo.
			 else {
				 
				 // Não define nenhuma sala de destino.
				 // A porta permanece trancada.
				 _target = noone;
			 }
		}
  }
  
 // Para qualquer outra sala do jogo
 else {
	 // Define como destino a próxima sala da sequência
	 _target = room_next(room);
 }
 
 // Verifica se a sala de destino existe.
 if (room_exists(_target)){
	 
	 // Cria o objeto responsável pelo efeito de transição.
    // (0,0) = posição onde será criado.
    // -9999 = profundidade muito alta para aparecer na frente de tudo.
	var _inst = instance_create_depth(
	0,
	0,
	-9999,
	obj_efeito_transicao);
	
	// Informa ao objeto de transição qual será a sala de destino
	_inst.target_room = _target;
 }

