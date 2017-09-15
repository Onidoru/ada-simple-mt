with Data;
with Ada.Text_IO; use Ada.Text_IO;

procedure lab is
  N : Long_Integer := 750;
  pragma SUPPRESS(All_Checks);
  package This_Data is new Data(N);
  use This_Data;

  task T1 is
    pragma Priority(1);
    pragma Storage_Size(30_000_000);
    pragma CPU(1);
  end;
  task body T1 is
    generate : Boolean := True;
    A : Vector;
  begin
    Put_Line("T1 started");

    delay 0.1;
    A := Func1(generate);
    Put_Line("T1s is done");
    delay 0.2;

    if A'Length <= 5 then
      Print(A);
    end if;

  end T1;

  task T2 is
    pragma Priority(1);
    pragma Storage_Size(30_000_000);
    pragma CPU(2);
  end;
  task body T2 is
    generate : Boolean := True;
    MG : Matrix;
  begin
    Put_Line("T2 started");

    delay 0.3;
    MG := Func2(generate);
    delay 0.4;

    if MG'Length <= 5 then
      Print(MG);
    end if;

    Put_Line("T2s is done");
  end T2;

  task T3 is
    pragma Priority(10);
    pragma Storage_Size(30_000_000);
    pragma CPU(1);
  end;
  task body T3 is
    generate : Boolean := True;
    S : Integer;
  begin
    Put_Line("T3 started");

    delay 0.5;
    S := Func3(generate);
    delay 0.6;

    Put_Line("T3s is done");
  end T3;

  begin
    null;
end lab;
