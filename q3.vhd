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

entity q3 is
    Port (  X,Y             : in std_logic_vector(7 downto 0);
            CLK, S1,S0      : in std_logic;
            LDA,LDB         : in std_logic;
            RB              : out std_logic_vector(7 downto 0));
end q3;

architecture Logic of q3 is
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
signal s_mux_result1 : std_logic_vector(7 downto 0);
signal s_mux_result2 : std_logic_vector(7 downto 0);
signal s_ra_result : std_logic_vector(7 downto 0);
signal s_rb_result : std_logic_vector(7 downto 0);
signal s_rb_and_result : std_logic_vector(7 downto 0);
begin
    rga: reg8
    port map ( REG_IN => s_mux_result1,
                LD => LDA,
                CLK => CLK,
                REG_OUT => s_ra_result );
    rgb: reg8
    port map ( REG_IN => s_mux_result2,
                LD => LDB,
                CLK => CLK,
                REG_OUT => s_rb_result);
    m1: mux2t1
    port map ( top => X,
                bottom => s_rb_result,
                SEL => S1,
                M_OUT => s_mux_result1);
    RB <= s_rb_result;
    m2: mux2t1
    port map ( top => s_ra_result,
                bottom => Y,
                SEL => S0,
                M_OUT => s_mux_result2);
                
    RB <= s_rb_result;

end Logic;
