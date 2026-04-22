/// @description Insert description here
//Invencibilidade do inimigo
if other.vida {
if (alarm[0] <=0){//se o alarme estiver em 0 ou menor pode sofrer dano
	vida -= 1 //pode perder 1 vida depois de 3 segundos
	alarm[0] = inv_tempo;// 3segundos sem poder sofrer dano
}
}