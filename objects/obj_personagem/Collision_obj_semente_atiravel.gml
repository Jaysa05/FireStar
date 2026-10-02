/// @description Colisão com semente atirável
if (!invencivel && alarm[0] <= 0) {
    vida -= 1;
    alarm[0] = inv_tempo;
    invencivel = true;
    }

with (other) {
    instance_destroy();
}
