# Seja bem vindo ao Robot Toy CLI

Esse projeto é parte do desafio técnico do processo seletivo da Pin People e consiste na CLI solicitada. Ele é bem simples, desenvolvido com **Ruby** (**você precisa tê-lo instalado em sua máquina**). Ele basicamente movimenta um Robô por uma mesa 5x5 de acordo com os comandos (acesse o [readme](https://github.com/danielarrais/robot-on-table/blob/master/README.md) do desafio para entender quais são) informados no terminal.

Para rodar o **Robot Toy** basta rodar o seguinte comando:

```Bash  
./game "COMMANDS"

#sample
./game "PLACE 2,2,NORTH                                                                                                                                         
		LEFT
		MOVE
		MOVE
		MOVE
		LEFT
		MOVE
		MOVE
		RIGHT
		RIGHT
		MOVE
		MOVE
		REPORT"
```  

Talvez você precise dar permissão de execução ao arquivo:

```Bash
chmod +x ./game
```

