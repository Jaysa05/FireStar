if alarm [0] <= 0 {//se o alarme estiver em 0 ou menor pode sofrer dano
	vida -= 1;
	alarm[0] = inv_tempo;
}

with (other){
	instance_destroy();
}

