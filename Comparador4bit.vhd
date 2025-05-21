library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Comparador4bit is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Equ : out STD_LOGIC;
           Grt : out STD_LOGIC;
           Lst : out STD_LOGIC);
end Comparador4bit;

architecture Logic of Comparador4bit is
	 -- Criando "variáveis" p/ facilitar a comparação bit a bit
    signal eq3, eq2, eq1, eq0 : STD_LOGIC;
    signal gt3, gt2, gt1, gt0 : STD_LOGIC;
    signal lt3, lt2, lt1, lt0 : STD_LOGIC;
begin
    -- Comparando bit a bit:
    eq3 <= A(3) xnor B(3);
    eq2 <= A(2) xnor B(2);
    eq1 <= A(1) xnor B(1);
    eq0 <= A(0) xnor B(0);
    
    gt3 <= A(3) and (not B(3));
    gt2 <= A(2) and (not B(2)) and eq3;
    gt1 <= A(1) and (not B(1)) and eq3 and eq2;
    gt0 <= A(0) and (not B(0)) and eq3 and eq2 and eq1;
    
    lt3 <= (not A(3)) and B(3);
    lt2 <= (not A(2)) and B(2) and eq3;
    lt1 <= (not A(1)) and B(1) and eq3 and eq2;
    lt0 <= (not A(0)) and B(0) and eq3 and eq2 and eq1;
    
    -- Saídas
    Equ <= eq3 and eq2 and eq1 and eq0; -- Se TODOS forem iguais
    Grt <= gt3 or gt2 or gt1 or gt0;	 -- Se al
    Lst <= lt3 or lt2 or lt1 or lt0;
end Logic;