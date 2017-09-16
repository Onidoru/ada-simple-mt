with Data;
with Ada.Text_IO; use Ada.Text_IO;

procedure lab is
  N : Long_Integer := 550;

  package This_Data is new Data(N);
  use This_Data;

  -- pragma SUPPRESS(All_Checks);

  task T1 is
    pragma Priority(1);
    pragma Storage_Size(999_000_000);
    pragma CPU(1);
  end;
  task body T1 is
    generate : Boolean := True;
    A : Vector;
  begin
    delay 0.1;
    Put_Line("T1 started");

    A := Func1(generate);
    delay 0.2;

    if A'Length <= 5 then
      Print(A);
    end if;

    Put_Line("T1 is done");
  end T1;


  task T2 is
    pragma Priority(1);
    pragma Storage_Size(75_000_000);
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

    Put_Line("T2 is done");
  end T2;

  task T3 is
    pragma Priority(2);
    pragma Storage_Size(75_000_000);
    pragma CPU(3);
  end;
  task body T3 is
    generate : Boolean := True;
    S : Integer;
  begin
    Put_Line("T3 started");

    delay 0.5;
    S := Func3(generate);
    delay 0.6;

    Put_Line("T3 is done");
  end T3;


  begin
    null;
end lab;
