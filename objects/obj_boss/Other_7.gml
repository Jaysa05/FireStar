/// @description Insert description here
/// @description Evento quando a animação termina
switch (estado) {
    case ESTADO_BOSS.MORTE:
        // Cria o objeto de transição para a próxima fase no lugar do boss
        instance_create_layer(x, y, "Instances", obj_transicao);
        instance_destroy();
        break;
        
    default:
        // Por enquanto, não faz nada nos outros estados
        break;
}

