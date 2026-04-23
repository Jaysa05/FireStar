/// @description Insert description here
switch (estado) {
    case ESTADO_BOSS.ESPADA:
    case ESTADO_BOSS.FOGO:
        estado = ESTADO_BOSS.PERSEGUINDO;
        timer_atual = timer_ataques; 
        break;
        
    case ESTADO_BOSS.MORTE:
        instance_destroy();
        break;
}

