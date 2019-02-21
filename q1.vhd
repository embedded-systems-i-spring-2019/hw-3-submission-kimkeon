----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2019 08:14:52 PM
-- Design Name: 
-- Module Name: q1 - Logic
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

entity mux2t1 is --- ENTITY
    port ( top,bottom : in std_logic_vector(7 downto 0);
            SEL : in std_logic;
            M_OUT : out std_logic_vector(7 downto 0));
end mux2t1;

architecture my_mux of mux2t1 is --- ARCHITECTURE
begin
    with SEL select
    M_OUT <=    top when '1',
                bottom when '0',
                (others => '0') when others;
end my_mux;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg8 is --- ENTITY
    port (REG_IN : in std_logic_vector(7 downto 0);
            LD,CLK : in std_logic;
            REG_OUT : out std_logic_vector(7 downto 0));
end reg8;

architecture reg8 of reg8 is --- ARCHITECTURE
begin
    reg: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (LD = '1') then
                REG_OUT <= REG_IN;
            end if;
        end if;
    end process;
end reg8;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity q1 is
    Port (A, B          : in std_logic_vector(7 downto 0);
            CLK, SEL    : in std_logic;
            LDA         : in std_logic;
            F           : out std_logic_vector(7 downto 0));
end q1;

architecture Logic of q1 is
    component mux2t1
        port ( top,bottom : in std_logic_vector(7 downto 0);
                SEL : in std_logic;
                M_OUT : out std_logic_vector(7 downto 0));
    end component;
    component reg8
        Port ( REG_IN : in std_logic_vector(7 downto 0);
                LD,CLK : in std_logic;
                REG_OUT : out std_logic_vector(7 downto 0));
    end component;
-- intermediate signal declaration
signal s_mux_result : std_logic_vector(7 downto 0);
begin
    ra: reg8
    port map ( REG_IN => s_mux_result,
                LD => LDA,
                CLK => CLK,
                REG_OUT => F );
    m1: mux2t1
    port map ( top => A,
                bottom => B,
                SEL => SEL,
                M_OUT => s_mux_result);

end Logic;
