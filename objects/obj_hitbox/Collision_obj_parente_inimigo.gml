// acessar o objeto que colidiu com a hitbox

if (other.object_index == obj_coelho_saltitante) exit;

with (other){
	// diminuir 1 ponto da vida desse objeto
	vida -= 1;
	hit = true;
}
