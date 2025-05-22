library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.funcoes.all;

entity Projeto_ULA is
	-- Definição de portas de entrada e saída
   Port ( 
		SW: In std_logic_vector (10 downto 0);
		HEX0, HEX2, HEX4, HEX6: out std_logic_vector (0 to 6);
		LEDR: out std_logic_vector (5 downto 0)
    );
end Projeto_ULA;

architecture Sistema of Projeto_ULA is
    -- Resultados de cada operação
    signal add_result, sub_result, mul_result : STD_LOGIC_VECTOR(3 downto 0);
    signal and_result, or_result, Bbarra : STD_LOGIC_VECTOR(3 downto 0);
    
    -- p/ Flags
    signal add_cout, sub_cout : STD_LOGIC;
    signal add_overflow, sub_overflow, Nzero: STD_LOGIC;
    signal cmp_equ, cmp_grt, cmp_lst : STD_LOGIC;
	 -- Componentes
	 signal A : STD_LOGIC_VECTOR(3 downto 0);
    signal B : STD_LOGIC_VECTOR(3 downto 0);
    signal AluOp : STD_LOGIC_VECTOR(2 downto 0);
    signal Result : STD_LOGIC_VECTOR(3 downto 0);
    signal Zero : STD_LOGIC;
    signal CarryOut : STD_LOGIC;
    signal Overflow : STD_LOGIC;
    signal Equ : STD_LOGIC;
    signal Grt : STD_LOGIC;
    signal Lst : STD_LOGIC;
    
begin

	A <= SW(10 downto 7);
	B <= SW(6 downto 3);
	AluOp <= SW(2 downto 0);


    -- Instanciação dos componentes
    STAGE0: RippleCarryAdder port map(A, B, '0', add_result, add_cout);
    
    STAGE1: RippleCarryAdder port map(A, not B, '1', sub_result, sub_cout);
    
    STAGE2: Mult2x2 port map( A(1 downto 0), B(1 downto 0), mul_result);
    
    STAGE3: Comparador4bit port map(A, B, cmp_equ, cmp_grt, cmp_lst);
	 
	 STAGE4: Comparador4bit port map(Result, "0000", Zero, Nzero, Nzero);
        
    -- Operações lógicas
    and_result <= A and B;
    or_result  <= A or B;
    Bbarra <= not B;
	 -- Verificação das Flags
	 add_overflow <= (A(3) and B(3) and NOT Result(3)) or (NOT A(3) AND not_result(3) and Result(3));	--Define o overflow da SOMA
     sub_overflow <= (A(3) and not_result(3) and NOT Result(3)) OR (NOT A(3) and B(3) and Result(3));	--Define o overflow da SUBTRAÇÃO

    -- Seleção da operação
    with AluOp select 
	 Result <= add_result    when "100",
				  sub_result    when "101",
				  mul_result    when "110",
				  and_result    when "001",
				  or_result     when "010",
				  Bbarra    	 when "011",
				  "0000"        when others;  -- NOP ou operação inválida
				  
	 -- FLAGS: 
				  
	 -- Carry Out
    with AluOp select
	 LEDR(0) <= add_cout     when "100",
					 sub_cout     when "101",
					 '0'      when others;
	 -- Overflow
	 with AluOp select
	 LEDR(2) <= add_overflow     when "100",
				sub_overflow     when "101",
				'0'              when others;
	 -- Igual				 
    with AluOp select
	 LEDR(3) <= cmp_equ     when "111",
				'0'        when others;
				
	 -- Maior							 
    with AluOp select
	 LEDR(4) <= cmp_grt     when "111",
				'0'        when others;
				
	 -- Menor							 
    with AluOp select
	 LEDR(5) <= cmp_lst     when "111",
				'0'        when others;
   
    -- Zero (depende de nop)
	 				 
    with AluOp select
	 LEDR(1) <= '0'     when "000",
					Zero		when others;
				
	 -- Configuração dos LEDs
	with A select
	
	HEX4 <=     "0000001" when "0000",
                "1001111" when "0001",
                "0010010" when "0010",
                "0000110" when "0011",
                "1001100" when "0100",
                "0100100" when "0101",
                "0100000" when "0110",
                "0001111" when "0111",
                "0000000" when "1000",
                "0001100" when "1001",
                "0001000" when "1010",
                "1100000" when "1011",
                "0110001" when "1100",
                "1000010" when "1101",
                "0110000" when "1110",
                "0111000" when "1111",
                "1111111" when others;
					 
		with B select
					 
		HEX2 <=   "0000001" when "0000",
                "1001111" when "0001",
                "0010010" when "0010",
                "0000110" when "0011",
                "1001100" when "0100",
                "0100100" when "0101",
                "0100000" when "0110",
                "0001111" when "0111",
                "0000000" when "1000",
                "0001100" when "1001",
                "0001000" when "1010",
                "1100000" when "1011",
                "0110001" when "1100",
                "1000010" when "1101",
                "0110000" when "1110",
                "0111000" when "1111",
                "1111111" when others;
					 
		with Result select
		
		HEX6 <=   "0000001" when "0000",
                "1001111" when "0001",
                "0010010" when "0010",
                "0000110" when "0011",
                "1001100" when "0100",
                "0100100" when "0101",
                "0100000" when "0110",
                "0001111" when "0111",
                "0000000" when "1000",
                "0001100" when "1001",
                "0001000" when "1010",
                "1100000" when "1011",
                "0110001" when "1100",
                "1000010" when "1101",
                "0110000" when "1110",
                "0111000" when "1111",
                "1111111" when others;
    
end Sistema;