/// @description Colisão com projétil de tomate
if (!invencivel && alarm[0] <= 0) {
    vida -= 1;
    alarm[0] = inv_tempo;
    invencivel = true;
    }

with (other) {
    instance_destroy();
}
