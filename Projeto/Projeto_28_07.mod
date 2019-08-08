MODULE Module1

CONST robtarget pinicial:=[[752.34,1.85,166.34],[0.200386,0.0252645,0.979387,0.00297478],[0,2,-2,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
CONST num vel:= 1000;!Velocidade de movimentação
CONST speeddata velocidade:= [vel,vel*10,vel*1000,1000];
    !***********************************************************
    !
    ! Module:  Module1
    !
    ! Description:
    !   <Insert description here>
    !
    ! Author: Gabriel
    !
    ! Version: 1.0
    !
    !***********************************************************
    
    
    !***********************************************************
    !
    ! Procedure main
    !
    !   This is the entry point of your program
    !
    !***********************************************************
    PROC desenhar(num i)

        VAR iodev data;
        VAR robtarget subir;
        VAR robtarget p_atual;
        VAR num px;
        VAR num py;
        VAR num n_strokes;
        VAR num n_elementos;
        VAR robtarget p_comeco;
!Defina o começo do desenho
        p_comeco := Offs(pinicial,0,-255*i,0);
!abre o arquivo onde a data para a leitura está escrito
        Open "C:/Users/Gabriel/Desktop/2019.2/Fundamentos da Robótica/Projeto" \File:= "data.doc", data\Read;
!le o numero de strokes(linha continua) que ele deverá fazer
        n_strokes := ReadNum(data\Delim:=" "); 
!Vai para o ponto incial do desenho
        subir :=  Offs(p_comeco,0,0,50);
        MoveL p_comeco,velocidade, fine, tool0;
        MoveL subir, velocidade, fine, tool0;

        FOR j FROM 1 TO n_strokes DO
!Para cada stroke ele faz n_elementos retas
            n_elementos := ReadNum(data\Delim:=" ");

            FOR k FROM 1 TO n_elementos DO
                px := ReadNum(data\Delim:=" ");
                py := ReadNum(data\Delim:=" "); 
                p_atual := Offs(p_comeco,-px,py,0);

                IF k = 1 THEN
!Na primeira "canetada" o robo se move primeiramente para acima do ponto em que ele ira desenhar
                    MoveL Offs(p_atual,0,0,50),velocidade, fine ,tool0;
                ENDIF
!Executa um pedaço do stroke
                MoveL p_atual, velocidade, fine, tool0;
            ENDFOR
!Ao final ele sobe para ficar pronto para se locomover até o ponto inicial do proximo stroke
            MoveL Offs(p_atual,0,0,50), velocidade, fine, tool0;
        ENDFOR
!Ao final o robo vai para uma poscição segura final, aguardando o encerramento do programa ou o proximo desenho
        MoveL Offs(p_atual,0,0,50), velocidade, fine, tool0;
        MoveL subir, velocidade, fine, tool0;
        Close data;

    ENDPROC
    PROC main()
!Variaveis para a comunicação com o Server
        VAR iodev data;
        VAR socketdev client;
        VAR string data_string{20};
        VAR string escolha_usuario;
!Variaveis Auxiliares
        VAR num aux;
        VAR num continuar;
!Começo!
        MoveL pinicial, velocidade, fine, tool0;
!Loop para desenhar diversos desenhos
        aux:=0;
        WHILE aux<>-1 DO 
!Usuario da entrada com uma string de sua escolha
            escolha_usuario := UIAlphaEntry(
                        \Header:= "Projeto -Fundamentos de Robotica",
                        \Message:= "¿O que quieres desenhar?"
                        \Icon:=iconInfo
                        \InitString:= "random");
!Criação do socket e conexão ao IP onde o server está hospedado. O IP deverá ser o fornecido pelo robo quando feita a conexão LAN entre ele e seu computador
            SocketCreate client;
            SocketConnect client,"127.0.0.1",8080;
            SocketSend client, \Str := escolha_usuario;
!Abri o arquivo onde as informaçoes sobre o desenho serão armazenada ( Já limpo pelo Server)
            Open "C:/Users/Gabriel/Desktop/2019.2/Fundamentos da Robótica/Projeto" \File:= "data.doc", data\Write;
!Aguarda receber toda a informação. A função SocketReceive tem limite de 81 bytes para string
            FOR i FROM 1 TO 20 DO
                SocketReceive client, \Str:=data_string{i},\Time:=0.3;!Armazena em um array de strings temporario
                Write data , data_string{i},\NoNewLine;!Escreve a data recebida no arquivo imediatamente
            ENDFOR

            Close data;
!Com a data recebida o robo começa a realizar o desenho
            desenhar aux;
!Ao final o usuario escolhe se quer continuar
            TPReadFK continuar, "¿Quieres desenhar outro sketch?", "Sí", "No", stEmpty,stEmpty,stEmpty;
            IF continuar = 1 THEN
                aux := aux + 1;
            ELSEIF continuar = 2 THEN
                aux :=-1;
                SocketSend client, \Str := "desligar_server";! se a rotina for encerrada o client manda um sinal para desligar o server
            ENDIF
!Fecha a conexão para se fazer outra caso um outro desenho for ser desenhado
            SocketClose client;
!limpa o array de strings para ficar pronto para receber novos dados
            FOR i FROM 1 TO 20 DO
                data_string{i} := "";
            ENDFOR

        ENDWHILE
!O robo se move para uma posição segura
        MoveL Offs(pinicial,0,0,100),velocidade, fine, tool0;
        Stop;
!Handler de erro para realizar a espera pela data
         ERROR
            IF ERRNO = ERR_SOCK_TIMEOUT THEN
                TRYNEXT;
            ENDIF
    ENDPROC
ENDMODULE