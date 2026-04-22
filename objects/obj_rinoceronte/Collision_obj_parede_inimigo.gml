// 1. Inverte a direção instantaneamente (Se era -2, vira 2. Se era 2, vira -2)
hspeed = hspeed * -1;
// 2. Vira a imagem como num espelho dependendo de para onde ele vai
if (hspeed > 0) {
    image_xscale = -1; // Vira o sprite para olhar para a Direita
} else {
    image_xscale = 1;  // Vira o sprite para olhar para a Esquerda
}