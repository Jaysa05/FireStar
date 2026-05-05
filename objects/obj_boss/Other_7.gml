/// @description Insert description here
/// @description Evento quando a animação termina
switch (estado) {
    case ESTADO_BOSS.MORTE:
        // Cria a tela de vitória antes de sumir com o boss
        instance_create_layer(0, 0, "Instances", obj_vitoria);
        instance_destroy();
        break;
        
    default:
        // Por enquanto, não faz nada nos outros estados
        break;
}

