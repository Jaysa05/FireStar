/// @description Insert description here
// Verifica se o inimigo está vivo
if (other.vida > 0) {
    
    // IGNORA DANO POR CONTATO DIRETO COM O MONSTRO DE GELO
    // O jogador só toma dano pelos ataques telegrafados do próprio boss (gerenciados no Step dele)
    if (other.object_index == obj_mostro_gelo || object_is_ancestor(other.object_index, obj_mostro_gelo)) {
        exit;
    }
    
    // REGRA PARA O MINOTAURO:
    // O jogador só toma dano se o Minotauro estiver no estado de investida (atacando)
    if (other.object_index == obj_minotauro || object_is_ancestor(other.object_index, obj_minotauro)) {
        if (other.estado != "investida") {
            exit; // Ignora o dano se não estiver no ataque
        }
    }
    
    // VERIFICA SE ESTÁ PULANDO EM CIMA DO COELHO SALTITANTE
    if (other.object_index == obj_coelho_saltitante && vveloc > 0 && y < other.y) {
        
        other.vida = 0; // Mata o coelho
        vveloc = -forca_pulo; // Faz o personagem quicar para cima
        
        // Define o drop para ser 10 frutas na hora de morrer
        other.item_drop = obj_fruta;
        other.item_drop_quantidade = 10;
        
        exit; // Sai do código para que o personagem não tome dano!
    }

    // SISTEMA NORMAL DE TOMAR DANO
    if (alarm[0] <= 0) { //se o alarme estiver em 0 ou menor pode sofrer dano
        vida -= 1; //perde 1 vida
        alarm[0] = inv_tempo; // tempo sem poder sofrer dano
    }
}