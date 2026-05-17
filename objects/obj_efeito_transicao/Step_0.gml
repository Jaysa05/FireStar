// Atualiza a transparência:
// Se fade = 1 → alpha aumenta (escurece)
// Se fade = -1 → alpha diminui (clareia)
alpha += fade * spd;
if(alpha >=1) {
	alpha = 1;
	fade = -1;
	
	
    // Se existe uma sala definida E ainda não estamos nela
	if (target_room != noone && room != target_room){
		room_goto(target_room)
        // Isso acontece com a tela preta (transição suave)
	}
	
}

if ( alpha <= 0 && fade = -1){
	instance_destroy()
}
