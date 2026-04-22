/// @description Insert description here
if alarm [0] <= 0 {//se o alarme estiver em 0 ou menor pode sofrer dano
	vida -= 1;//perde 1 vida 
	alarm[0] = inv_tempo;//3 segundos sem poder tomar dano
}

with (other){
	instance_destroy(); //Destroe o projétil quando colidir com o personagem
}

