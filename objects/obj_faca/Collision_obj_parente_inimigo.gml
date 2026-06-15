/// @description Insert description here

// Se for o coelho saltitante, ele não toma dano da faca
if (other.object_index == obj_coelho_saltitante) {
	instance_destroy();
	exit;
}

with (other){
	if (!variable_instance_exists(id, "vulneravel") || vulneravel == true) {
		vida -= 1;
		hit = true;
	}
}
instance_destroy()