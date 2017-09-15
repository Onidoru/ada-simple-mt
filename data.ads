with Ada.Numerics.Discrete_Random;
with Ada.Text_IO; use Ada.Text_IO;

generic
  N : in Long_Integer;

package Data is

  type Matrix is array(1..N, 1..N) of Integer;
  type Vector is array(1..N) of Integer;

  function Func1(generate : in Boolean) return Vector;
  function Func2(generate : in Boolean) return Matrix;
  function Func3(generate : in Boolean) return Integer;

  procedure Print(M : in Matrix);
  procedure Print(V : in Vector);

end Data;
