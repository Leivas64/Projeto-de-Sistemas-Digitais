library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mult2x2 is
    Port ( A : in STD_LOGIC_VECTOR (1 downto 0);
           B : in STD_LOGIC_VECTOR (1 downto 0);
           Product : out STD_LOGIC_VECTOR (3 downto 0));
end Mult2x2;

architecture Logic of Mult2x2 is
    signal p0, p1, p2, p3 : STD_LOGIC;
    signal sum1, carry1 : STD_LOGIC;
begin
    -- Primeiro nível de multiplicação
    p0 <= A(0) and B(0);
    p1 <= A(1) and B(0);
    p2 <= A(0) and B(1);
    p3 <= A(1) and B(1);
    
    -- Soma dos "resultados"
    Product(0) <= p0;
    
    -- Somador para o bit 1
    Product(1) <= p1 xor p2;
    carry1 <= p1 and p2;
    
    -- Bit 2
    Product(2) <= p3 xor carry1;
    
    -- Bit 3 -> (Carry Out)
    Product(3) <= p3 and carry1;
end Logic;