library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

	-- Package com os componentes:
package funcoes is
    -- Somador Completo (1-bit)
    component FullAdder is
        Port ( A : in STD_LOGIC;
               B : in STD_LOGIC;
               Cin : in STD_LOGIC;
               Sum : out STD_LOGIC;
               Cout : out STD_LOGIC);
    end component;
    
    -- Somador/Subtrator de 4 bits
    component RippleCarryAdder is
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
               B : in STD_LOGIC_VECTOR (3 downto 0);
               Cin : in STD_LOGIC;
               Sum : out STD_LOGIC_VECTOR (3 downto 0);
               Cout : out STD_LOGIC
					);
    end component;
    
    -- Multiplicador 2x2 bits
    component Mult2x2 is
        Port ( A : in STD_LOGIC_VECTOR (1 downto 0);
               B : in STD_LOGIC_VECTOR (1 downto 0);
               Product : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    -- Comparador de 4 bits
    component Comparador4bit is
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
               B : in STD_LOGIC_VECTOR (3 downto 0);
               Equ : out STD_LOGIC;
               Grt : out STD_LOGIC;
               Lst : out STD_LOGIC);
    end component;
end package funcoes;