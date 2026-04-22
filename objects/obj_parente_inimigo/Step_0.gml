/// @description Insert description here
// Verifica se o inimigo acabou de sofrer um golpe
if hit == true {
    veloc = 0;        // Para o movimento horizontal temporariamente (fica “congelado”)
    alarm[1] = 5;     // Inicia um timer de 5 frames (geralmente usado para efeitos de hit, como piscar ou recuo)
    hit = false;      // Reseta o flag de hit, para não entrar nesse bloco novamente até receber outro dano
}

// Verifica se a vida do personagem/inimigo chegou a zero
// Verifica se a vida chegou a zero
if vida <= 0 {
    if reset == false {
        image_index = 0; 
        reset = true;    
    }

    sprite_index = sprite_morrendo; 
    
    // O SEGREDO ESTÁ AQUI: Quando a fumaça da morte termina!
    if scr_fim_da_animacao(){
        
        // Se ele tem algum item para dropar, ele cria
    if (item_drop != noone) {  
        instance_create_layer(x, y - 25, "colisao", item_drop); 
    }
        
        instance_destroy(); 
    }


}
