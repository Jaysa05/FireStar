/// @description Insert description here
// Se pegou uma melhoria
if obj_faca.melhoria == true {

    // Ativa o uso da faca
    faca = true;

    // Define 5 usos disponíveis
    faca_cargas = 5;

    // Executa ações no outro objeto (ex: item coletado)
    with (other) {

        // Destroi o item após ser coletado
        instance_destroy();
    }
}

