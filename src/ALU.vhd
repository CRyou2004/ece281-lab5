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
-- TODO
    generic(N: integer := 8);
    Port (i_A : in STD_LOGIC_VECTOR (N-1 downto 0);
          i_B : in STD_LOGIC_VECTOR (N-1 downto 0);
          o_flag : out STD_LOGIC_VECTOR (2 downto 0);
          o_ALU : out STD_LOGIC_VECTOR (N-1 downto 0);
          i_op : in STD_LOGIC_VECTOR (2 downto 0));
end ALU;

architecture behavioral of ALU is 
  
	-- declare components and signals
signal w_B      : STD_LOGIC_VECTOR (N-1 downto 0);
signal w_ALUout : STD_LOGIC_VECTOR (N-1 downto 0);
signal w_cin    : STD_LOGIC_VECTOR (0 downto 0);
signal w_cout   : STD_LOGIC;
signal w_add    : STD_LOGIC_VECTOR (N downto 0);
  
begin
	-- PORT MAPS ----------------------------------------
    w_cin <= i_op(0 downto 0);
    
    w_B <= not i_B when i_op = "001" else i_B;
    w_add(N-1 downto 0) <= std_logic_vector(unsigned(i_A) + unsigned(w_B) + unsigned(w_cin));
    
   -- w_shift <= std_logic_vector(shift_left(unsigned(i_A), to_integer(unsigned(i_B(2 downto 0))))) when op(0) = '0';
   
   o_ALU <= w_add(N-1 downto 0) when i_op(2 downto 1) = "00";
   
   o_flag(0) <= w_add(N);
   o_flag(1) <= '1' when w_ALUout = "00000000" else '0';
   o_flag(2) <= w_ALUout(N-1);
	
	
	-- CONCURRENT STATEMENTS ----------------------------
	
	
	
end behavioral;

