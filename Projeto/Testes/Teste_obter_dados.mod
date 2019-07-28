MODULE Module1
CONST robtarget pinicial:=[[1103.88,-81.65,114.32],[0.499873,-0.00018931,0.866098,0.0],[-1,1,-2,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
PROC main()
        VAR iodev arquivo;
        VAR num entrada;
        VAR num entrada2;
        VAR num entrada3;
        Open "C:/Users/Gabriel/Desktop/2019.2/Fundamentos da Robótica/Projeto" \File:= "data.doc", arquivo\Read;
        entrada := ReadNum(arquivo\Delim:=" ");
        entrada2 := ReadNum(arquivo\Delim:=" ");
        entrada3 := ReadNum(arquivo\Delim:=" ");
        TPWrite "Leitura: " \Num:=entrada;
        TPWrite "Leitura2:: " \Num:=entrada2;
        TPWrite "Leitura3:: " \Num:=entrada3;
        Close arquivo;
        Stop;
    ENDPROC
ENDMODULE