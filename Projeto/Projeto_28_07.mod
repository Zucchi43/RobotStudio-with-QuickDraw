MODULE Module1
CONST robtarget pinicial:=[[839.03,-3.40,115.91],[0.364499,-0.0364333,0.929236,0.0483098],[-1,1,-2,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
CONST num vel:= 1000;
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
    PROC desenhar()
        VAR iodev data;
        VAR robtarget subir;
        VAR robtarget p_atual;
        VAR num px;
        VAR num py;
        VAR num i;
        VAR num n_strokes;
        VAR num n_elementos;
        Open "C:/Users/Gabriel/Desktop/2019.2/Fundamentos da Robótica/Projeto" \File:= "data.doc", data\Read;
        n_strokes := ReadNum(data\Delim:=" ");   
        i:=0;
        subir :=  Offs(pinicial,0,0,50);
        MoveL pinicial,velocidade, fine, tool0;
        MoveL subir, velocidade, fine, tool0;
        FOR j FROM 1 TO n_strokes DO
            n_elementos := ReadNum(data\Delim:=" ");
            FOR k FROM 1 TO n_elementos DO
                px := ReadNum(data\Delim:=" ");
                py := ReadNum(data\Delim:=" "); 
                p_atual := Offs(pinicial,px,py,0);
                IF k = 1 THEN
                    MoveL Offs(p_atual,0,0,50),velocidade, fine ,tool0;
                ENDIF
                MoveL p_atual, velocidade, fine, tool0;
            ENDFOR
            MoveL Offs(p_atual,0,0,50), velocidade, fine, tool0;
        ENDFOR
        MoveL Offs(p_atual,0,0,50), velocidade, fine, tool0;
        MoveL subir, velocidade, fine, tool0;
        MoveL pinicial,velocidade,fine,tool0;
        Close data;
    ENDPROC
    PROC main()
        VAR iodev data;
        VAR iodev im;       
        VAR socketdev client;
        VAR rawbytes data_bytes{10};
        VAR string data_string{20};
        VAR string escolha_usuario;
        VAR icondata imagem;
            escolha_usuario := UIAlphaEntry(
                        \Header:= "Projeto -Fundamentos de Robotica",
                        \Message:= "O que quieres desenhar?"
                        \Icon:=iconInfo
                        \InitString:= "flower");
        SocketCreate client;
        SocketConnect client,"127.0.0.1",8080;
        SocketSend client, \Str := escolha_usuario;
        Open "C:/Users/Gabriel/Desktop/2019.2/Fundamentos da Robótica/Projeto" \File:= "data.doc", data\Write;
        FOR i FROM 1 TO 20 DO
        SocketReceive client, \Str:=data_string{i},\Time:=0.3;
        Write data , data_string{i},\NoNewLine;
        ENDFOR
        Close data;
        SocketClose client;
        desenhar;
        Stop;
         ERROR
            IF ERRNO = ERR_SOCK_TIMEOUT THEN
                TRYNEXT;
            ENDIF
    ENDPROC
ENDMODULE