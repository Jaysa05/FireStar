if (other.vida > 0) {
    
    if (other.object_index == obj_coelho_saltitante && vveloc > 0 && y < other.y) {
        
        other.vida = 0;
        vveloc = -forca_pulo;
        
        other.item_drop = obj_fruta;
        other.item_drop_quantidade = 10;
        
        exit;
    }

    // SISTEMA NORMAL DE TOMAR DANO
    if (alarm[0] <= 0) { //se o alarme estiver em 0 ou menor pode sofrer dano
        vida -= 1;
        alarm[0] = inv_tempo;
    }
}