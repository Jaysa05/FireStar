/// @description Insert description here
/// @description Evento quando a animação termina
switch (estado) {
    case ESTADO_BOSS.MORTE:
        instance_destroy();
        break;
        
    default:
        // Por enquanto, não faz nada nos outros estados
        break;
}

