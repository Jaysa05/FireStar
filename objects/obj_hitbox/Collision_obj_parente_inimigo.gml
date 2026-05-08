/// @description Insert description here
// acessar o objeto que colidiu com a hitbox

// Se for o coelho saltitante, ele não toma dano de ataque normal
if (other.object_index == obj_coelho_saltitante) exit;

with (other){
	// diminuir 1 ponto da vida desse objeto
	vida -= 1;
	hit = true;
}
