
if (other.object_index == obj_coelho_saltitante) {
	instance_destroy();
	exit;
}

with (other){
	vida -= 1;
	hit = true;
}
instance_destroy()