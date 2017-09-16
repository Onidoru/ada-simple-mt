with Ada.Numerics.Discrete_Random;
with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.unbounded;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Integer_Text_IO;

package body Data is

  procedure Print(V : in Vector) is

  begin -- Print
    for i in V'range(1) loop
      Put(V(i));
    end loop;
  end Print;

  procedure Print(M : in Matrix) is

  begin -- Print
    for i in M'range(1) loop
      for j in M'range(2) loop
        Put(M(i, j));
      end loop;
      New_Line;
    end loop;
  end Print;

  procedure Get(M : in out Matrix) is

  begin -- Get
    Put("Input Matrix: ");
    for i in M'range(1) loop
      for j in M'range(2) loop
         M(i, j) := Integer'Value(Get_Line);
      end loop;
    end loop;
  end Get;

  procedure Get(V : in out Vector) is

  begin -- Get
    Put("Input Vector: ");
     for i in V'range(1) loop
        V(i) := Integer'Value(Get_Line);
     end loop;
  end Get;

  procedure Generate(M : in out Matrix) is
    subtype r is Integer range -50..50;
    package Random_int is new Ada.Numerics.Discrete_Random (r);
    use Random_int;
    G : Generator;
  begin -- Generate
    Reset(G);
    for i in M'range(1) loop
      for j in M'range(2) loop
        M(i, j) := Random(G);
      end loop;
    end loop;
  end Generate;

  procedure Generate(V : in out Vector) is
    subtype r is Integer range -50..50;
    package Random_int is new Ada.Numerics.Discrete_Random (r);
    use Random_int;
    G : Generator;
  begin -- Generate
    Reset(G);
      for i in V'range(1) loop
          V(i) := Random(G);
      end loop;
  end Generate;

   function Transpose (X : in Matrix) return Matrix is
      result : Matrix;
   begin -- Transpose
      for i in X'range(1) loop
         for j in X'range(2) loop
            result(j, i) := X(i, j);
         end loop;
      end loop;
      return result;
   end Transpose;

   function Multiply (Left : in Vector; Right : in Matrix) return Vector is
    result : Vector;
   begin -- Multiply
      for i in Right'range(1) loop
         result(i) := 0;
         for j in Left'range loop
            result(i) := result(i) + Left(j) * Right(j, i);
         end loop;
      end loop;
      return result;
   end Multiply;

   function Multiply (Left, Right : in Vector) return Integer is
      result : Integer := 0;
   begin -- Multiply
      for i in Left'range loop
         result := result + Left(i) * Right(i);
      end loop;
      return result;
   end Multiply;

   function Multiply (Left, Right : in Matrix) return Matrix is
      product : Integer;
      result : Matrix;
   begin -- Multiply
      for i in Left'range(1) loop
         for j in Right'range(2) loop
            product := 0;
            for K in Right'range(1) loop
               product := product + Left(i, K) * Right(K, j);
            end loop;
            result(i, j) := product;
         end loop;
      end loop;
      return result;
   end Multiply;

   function Multiply(Left : in Vector; Right : in Integer) return Vector is
    result : Vector;
   begin -- Multiply
    for i in Left'range(1) loop
      result(i) := Left(i) * Right;
    end loop;
    return result;
   end Multiply;

   function Add(Left, Right : in Vector) return Vector is
    result : Vector;
   begin -- Add
     for i in Left'range(1) loop
       result(i) := Left(i) + Right(i);
     end loop;
     return result;
   end Add;

   function Sub(Left, Right : in Vector) return Vector is
     result : Vector;
   begin -- Sub
     for i in Left'range(1) loop
       result(i) := Left(i) - Right(i);
     end loop;
     return result;
   end Sub;

   function Add(Left, Right : in Matrix) return Matrix is
    result : Matrix;
   begin -- Add
    for i in Left'range(1) loop
      for j in Left'range(2) loop
        result(i, j) := Left(i, j) + Right(i, j);
      end loop;
    end loop;
    return result;
   end Add;

   function Sub(Left, Right : in Matrix) return Matrix is
    result : Matrix;
   begin -- Sub
    for i in Left'range(1) loop
      for j in Left'range(2) loop
        result(i, j) := Left(i, j) - Right(i, j);
      end loop;
    end loop;
    return result;
   end Sub;

  procedure Sort(V : in out Vector) is
    temp : Integer;
  begin -- Sort
    for i in reverse V'Range loop
       for j in V'First .. i loop
          if V(i) < V(j) then
             Temp := V(i);
             V(j) := V(i);
             V(i) := temp;
          end if;
       end loop;
    end loop;
  end Sort;

  function Min(V : in Vector) return Integer is
    result : Integer := V(1);
  begin -- Min
    for i in 2..N loop
      if V(i) < result then
        result := V(i);
      end if;
    end loop;
    return result;
  end Min;

  -- 1\ A  = B*MiN(C) *(MA*MD+MD)
  function Func1(generate : in Boolean) return Vector is
    A, B, C : Vector;
    MA, MD : Matrix;
  begin -- Func1
    if generate = True then
      Data.Generate(B);
      Data.Generate(C);
      Data.Generate(MA);
      Data.Generate(MD);
    else
      Get(B);
      Get(C);
      Get(MA);
      Get(MD);
    end if;
    A := Multiply(Multiply(B, Min(C)), Add(Multiply(MA, MD), MD));
    return A;
  end Func1;

  -- 2\ MG = TRANS(MK) *(MH*MF)
  function Func2 (generate : in Boolean) return Matrix is
    MK, MH, MF : Matrix;
  begin -- Func2
    if generate = True then
      Data.Generate(MK);
      Data.Generate(MH);
      Data.Generate(MF);
    else
      Get(MK);
      Get(MH);
      Get(MF);
    end if;
    return Multiply(Transpose(MK), Multiply(MH, MF));
  end Func2;

  -- 3\ s  = MIN(A*TRANS(MB*MM)) + B*SORT(C)
  function Func3(generate : in Boolean) return Integer is
    A, B, C : Vector;
    MB, MM : Matrix;
  begin -- Func3
    if generate = True then
      Data.Generate(A);
      Data.Generate(B);
      Data.Generate(C);
      Data.Generate(MB);
      Data.Generate(MM);
    else
      Get(A);
      Get(B);
      Get(C);
      Get(MB);
      Get(MM);
    end if;
    return Min(Multiply(A, Transpose(Multiply(MB, MM))));
  end Func3;


end Data;
