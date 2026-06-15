/// @description Controle de Animação
// Trava no último frame da animação quando ela terminar (gelo totalmente erguido)
if (scr_fim_da_animacao()) {
    image_speed = 0;
    image_index = image_number - 1;
}
