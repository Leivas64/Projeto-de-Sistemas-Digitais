library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.funcoes.all;

entity RippleCarryAdder is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : out STD_LOGIC
           );
end RippleCarryAdder;

architecture Logic of RippleCarryAdder is
    signal carry : STD_LOGIC_VECTOR (4 downto 0);
begin
    carry(0) <= Cin;
    -- Usando o pkg FullAdder para o RippleCarryAdder
    
    STAGE0: FullAdder port map (A => A(0), B => B(0), Cin => carry(0), Sum => Sum(0), Cout => carry(1));
    
    STAGE1: FullAdder port map (A => A(1), B => B(1), Cin => carry(1), Sum => Sum(1), Cout => carry(2));
    
    STAGE2: FullAdder port map (A => A(2), B => B(2), Cin => carry(2), Sum => Sum(2), Cout => carry(3));
    
    STAGE3: FullAdder port map (A => A(3), B => B(3), Cin => carry(3), Sum => Sum(3), Cout => carry(4));
    
    Cout <= carry(4);
    
end Logic;