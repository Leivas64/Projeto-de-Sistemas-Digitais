library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC;
           Cout : out STD_LOGIC);
end FullAdder;

architecture Logic of FullAdder is
	-- definindo and1 e and2
    signal and1, and2 : STD_LOGIC;
begin
    
	 -- Fazendo a conta...
    Sum <= (A xor B) xor Cin;
    
    and1 <= A and B;
    and2 <= (A xor B) and Cin;
    -- p/ Definir Carry Out
    Cout <= and1 or and2;
end Logic;