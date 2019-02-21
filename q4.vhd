----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2019 10:44:32 PM
-- Design Name: 
-- Module Name: q4 - Logic
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
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

--entity two1decoder is
--    port (SEL   : in std_logic;
--            D0  : out std_logic;
--            D1  : out std_logic);
--end two1decoder;
--architecture adecoder of two1decoder is
--begin
--    D0 <= not SEL;
--    D1 <= SEL;
--end adecoder;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity q4 is
  Port (    X,Y                     : in std_logic_vector(7 downto 0);
            S1, S0, LDA, LDB, RD, CLK    : in std_logic;
            RB, RA                  : out std_logic_vector(7 downto 0));
end q4;

architecture Logic of q4 is
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
    signal s_ra_result1 : std_logic_vector(7 downto 0);
    signal s_rb_result1 : std_logic_vector(7 downto 0);
    signal raLD : std_logic;
    signal rbLD : std_logic;
    signal invertedCLK : std_logic;
begin
    invertedCLK <= (NOT CLK);
    raLD <= LDA and RD;
    REGA: reg8
    port map ( REG_IN => s_mux_result2,
                LD => raLD,
                CLK => invertedCLK,
                REG_OUT => RA );
    rbLD <= LDB and (NOT RD);
    REGB: reg8
    port map ( REG_IN => s_mux_result1,
                LD => rbLD,
                CLK => invertedCLK,
                REG_OUT => s_rb_result1 );
    m1: mux2t1
    port map ( top => X,
                bottom => Y,
                SEL => S1,
                M_OUT => s_mux_result1);
    m2: mux2t1
    port map ( top => s_rb_result1,
                bottom => Y,
                SEL => S0,
                M_OUT => s_mux_result2);

end Logic;
