/// @description Insert description here
// Atualiza a transparência:
// Se fade = 1 → alpha aumenta (escurece)
// Se fade = -1 → alpha diminui (clareia)
alpha += fade * spd;
if(alpha >=1) {
	alpha = 1;// Trava no preto máximo
	fade = -1;// Começa a clarear
	
	
    // Se existe uma sala definida E ainda não estamos nela
	if (target_room != noone && room != target_room){
		room_goto(target_room) // Troca para a sala desejada
        // Isso acontece com a tela preta (transição suave)
	}
	
}

if ( alpha <= 0 && fade = -1){//Se já clareou tudo, pode apagar esse objeto
	instance_destroy()// Destrói o objeto, pois o efeito terminou
    // Evita gastar memória à toa
}
