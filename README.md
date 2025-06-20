# Criando um Bootloader

&emsp; Esse código cria um bootloadersimples em assembly que lê uma frase digitada pelo usuário, aglutina à uma frase pré-estabelecida e exibe a string combinada na tela.

&emsp; No código assembly, das linhas 1-19, temos comandos para a inicialização segura do boot para o qemu como a inicialização do código apenas 33 espaços de mémoria depois. Nesse sentido também funcionam as linhas 87-88 que ditam o tamanho do código e incluem a assinatura de boot no código.

&emsp; A função puts serve para mostrar uma string contida em si na tela. Para tanto, ela loopa a função putch que imprime no terminal do usuário um caractere da string.

&emsp; Para guardar a string do usuario loopa-se a função .read-character, uma função local de main que guarda a string no registrador geral al e é interrompida caso o usuário aperte enter. A string no registrador al é mandada para outro buffer chamado buffer_space que é limitado a 255 bits.

&emsp; Por fim, chega-se a função .done_input. Essa função finaliza a string guardada em buffer_space colocando um zero no seu final. Ademais, exibe-se a aglutinação da seguinte forma: exibe-se a saudacao 'Ola, ' e em seguida exibe-se o que está em buffer_space usando si para tudo isso.
