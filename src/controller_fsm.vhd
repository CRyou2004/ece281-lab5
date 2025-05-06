----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:42:49 PM
-- Design Name: 
-- Module Name: controller_fsm - FSM
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controller_fsm is
  Port (i_reset : in std_logic;
        i_adv   : in std_logic;
        i_clk   : in std_logic;
        o_cycle : out std_logic_vector(3 downto 0)
   );
end controller_fsm;

architecture Behavioral of controller_fsm is

    signal f_Q, f_Q_next : std_logic_vector(3 downto 0);
    constant k_clk_period : time := 10ns;
    
begin
    f_Q_next <= "1000" when (i_reset = '1' or (f_Q = "0100" and i_adv = '1')) else
                "0001" when (i_adv = '1' and f_Q = "1000") else
                "0010" when (i_adv = '1' and f_Q = "0001") else
                "0100" when (i_adv = '1' and f_Q = "0010") else
                "1000";
    o_cycle <= f_Q;
    
    register_proc : process (i_clk, i_reset) 
            begin
                if i_reset = '1' then
                    f_Q <= "1000";        -- reset state is yellow
                elsif (rising_edge(i_clk) and i_adv='1') then
                    f_Q <= f_Q_next;    -- next state becomes current state
                end if;
            end process register_proc;

end Behavioral;