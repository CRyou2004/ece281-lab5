----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:50:18 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity ALU is
    Port ( i_regA : in std_logic_vector(7 downto 0);
           i_regB : in std_logic_vector(7 downto 0);
           i_op : in std_logic_vector(2 downto 0);
           o_result : out std_logic_vector(7 downto 0);
           o_flags : out std_logic_vector(2 downto 0));
end ALU;

architecture behavioral of ALU is 
	-- declare components and signals
	--components
	component fullAdder is
	Port(i_A : in std_logic_vector(7 downto 0);
	     i_B : in std_logic_vector(7 downto 0);
         i_Cin : in std_logic;
         o_S : out std_logic_vector(7 downto 0);
         o_Cout : out std_logic);
    end component;

    --signals
    signal w_sum : std_logic_vector(7 downto 0);
    signal w_B : std_logic_vector(7 downto 0);
    signal w_shifter : std_logic_vector(7 downto 0);
    signal w_opcode : std_logic_vector(2 downto 0);
    signal w_bitwise : std_logic_vector(7 downto 0);
    
begin
	-- PORT MAPS ----------------------------------------
	
	fullAdder_inst : fullAdder
	    Port map(
	    i_A => i_regA,
	    i_B => w_B,
	    i_Cin => i_op(2), --just looks at MSB of i_op
	    o_Cout => o_flags(0), --double check order of o_flags	    
	    o_S => w_sum
	    );
	   
	    --2:1 Mux for i_B inside add/sub component
	    w_B <= not(i_regB) when(i_op(2) = '1')
	           else i_regB;
	   
	   --2:1 Mux for to choose AND or OR inside bitwise AND/OR component
       w_bitwise <= i_regA or i_regB when i_op(2) = '1' else
                    i_regA and i_regB;
	   
	   --Shifter logic
	   w_shifter <= std_logic_vector(unsigned(i_regA) sll to_integer(unsigned(i_regB(2 downto 0)))) when i_op(2) = '0' else 
	               std_logic_vector(unsigned(i_regA) srl to_integer(unsigned(i_regB(2 downto 0))));
	   
	   o_result <= w_sum when i_op(1 downto 0) = "00" else
	               w_bitwise when i_op(1 downto 0) = "10" else
	               w_shifter when i_op(1 downto 0) = "01" else
	               "00000000" when i_op(1 downto 0) = "11";
	               
end behavioral;

