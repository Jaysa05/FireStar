// Cria uma instância do projétil (obj_tomate_projetil) na posição atual do inimigo
// x, y → posição do inimigo
// "Instances_2" → layer onde o projétil será colocado
instance_create_layer(x, y, "Instances_2", obj_tomate_projetil);

// Esse alarme conta quantos frames tem que se passar para ele exibir o frame que eu quero
alarm[0] = 90;
