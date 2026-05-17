

// Salva a vida atual do jogador em uma variável global
global.vida_save = vida;

// Salva se o jogador tem facas 
global.faca_save = faca;

// Salva as cargas/munições/energia da faca
global.faca_cargas_save = faca_cargas;

// Salva o tempo restante de invencibilidade
// max(0, alarm[0]) impede que o valor fique negativo
global.inv_save = max(0, alarm[0]);

// Se existir, o código para aqui para evitar duas transições ao mesmo tempo
if ( instance_exists(obj_efeito_transicao)) exit;

// Cria uma variável local chamada _target
// Ela vai guardar qual será a próxima sala
var _target = noone;

if ( room == rm_fase1)

 _target = rm_fase2;
 
 else if (room == rm_fase2)
 
 _target = rm_fase3;
 
 else if (room == rm_fase3)
 
  _target = rm_fase4;
  
  else _target = room_next(room);
  
  if (room_exists(_target)){
	  // obj_efeito_transicao Cria o objeto responsável pelo efeito de transição
	  // (0,0) = posição onde será criado
	  // -9999 = profundidade muito alta para aparecer na frente de tudo
	  var _inst = instance_create_depth(0,0, -9999, obj_efeito_transicao);
	  
	   _inst.target_room = _target;
  }
  
 

