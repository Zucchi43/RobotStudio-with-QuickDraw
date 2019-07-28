MODULE Module1
CONST robtarget pinicial:=[[1103.88,-81.65,114.32],[0.499873,-0.00018931,0.866098,0.0],[-1,1,-2,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];

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
    PROC main()
        VAR num flor {2,3} := [[85,84,70],[119,155,253]];
        VAR num flor2 {2,52} := [[84,80,46,26,4,0,4,47,33,28,26,34,42,50,52,61,72,84,100,100,89,95,125,128,112,149,155,157,150,132,143,166,178,179,167,146,153,166,171,170,157,139,137,145,149,149,144,132,119,106,87,76],[118,115,122,122,112,100,91,88,87,77,60,48,42,42,53,34,20,8,0,10,30,31,15,19,38,35,37,41,49,56,51,50,56,62,69,73,73,82,99,104,112,113,109,107,113,135,147,152,150,127,129,127]];
        VAR num flor3 {2,2} := [[100,91],[57,53]];
        CONST num vel:= 200;
        CONST speeddata velocidade:= [vel,vel*10,vel*1000,1000];
        VAR robtarget subir;
        VAR robtarget p_atual;      
        subir :=  Offs(pinicial,0,0,50);
        MoveL pinicial,velocidade, fine, tool0;
        FOR i FROM 1 to 3 DO
           	p_atual := Offs(pinicial,flor{1,i},flor{2,i},0);
        	MoveL p_atual, velocidade, fine, tool0;
        ENDFOR
        MoveL Offs(p_atual,0,0,50), velocidade, fine, tool0;
        FOR i FROM 1 to 52 DO
           	p_atual := Offs(pinicial,flor2{1,i},flor2{2,i},0);
        	MoveL p_atual, velocidade, fine, tool0;
        ENDFOR
        MoveL Offs(p_atual,0,0,50), velocidade, fine, tool0;
        FOR i FROM 1 to 2 DO
           	p_atual := Offs(pinicial,flor3{1,i},flor3{2,i},0);
        	MoveL p_atual, velocidade, fine, tool0;
        ENDFOR
       MoveL Offs(p_atual,0,0,50), v200, fine, tool0;
       MoveL subir, v200, fine, tool0;
        MoveL pinicial, velocidade, fine, tool0;
    ENDPROC
ENDMODULE