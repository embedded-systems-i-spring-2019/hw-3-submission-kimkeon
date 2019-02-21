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

entity my_4t1_mux is
    port (D3,D2,D1,D0 : in std_logic_vector(7 downto 0);
            SEL : in std_logic_vector(1 downto 0);
            MX_OUT : out std_logic_vector(7 downto 0));
end my_4t1_mux;
-- architecture
architecture mux4t1 of my_4t1_mux is
begin
    MX_OUT <= D3 when (SEL(1) = '1' and SEL(0) ='1') else
    D2 when (SEL(1) = '1' and SEL(0) ='0') else
    D1 when (SEL(1) = '0' and SEL(0) ='1') else
    D0 when (SEL(1) = '0' and SEL(0) ='0') else
    "00";
end mux4t1;

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

entity my_1t2_decoder is
    port (O : in std_logic;
            D0,D1 : out std_logic);
end my_1t2_decoder;

architecture the_1t2_decoder of my_1t2_decoder is
begin
    D0 <= not O;
    D1 <= O;
end the_1t2_decoder;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity q2 is
    Port (X,Y,Z          : in std_logic_vector(7 downto 0);
            CLK         : in std_logic;
            MS          : in std_logic_vector(1 downto 0);
            DS          : in std_logic;
            RB,RA       : out std_logic_vector(7 downto 0));
end q2;

architecture Logic of q2 is
    component mux4t1
        port ( D3,D2,D1,D0 : in std_logic_vector(7 downto 0);
                SEL : in std_logic_vector(1 downto 0);
                MX_OUT : out std_logic_vector(7 downto 0));
    end component;
    component reg8
        Port ( REG_IN : in std_logic_vector(7 downto 0);
                LD,CLK : in std_logic;
                REG_OUT : out std_logic_vector(7 downto 0));
    end component;
    component the_1t2_decoder
        Port (O         : in std_logic;
                D0,D1   : out std_logic);
    end component;
-- intermediate signal declaration
signal s_mux_result1 : std_logic_vector(7 downto 0);
signal ra_result    : std_logic_vector(7 downto 0);
signal rb_result    : std_logic_vector(7 downto 0);
signal dec_1        : std_logic;
signal dec_0        : std_logic;
signal invertedCLK  : std_logic;

begin
    invertedCLK <= (NOT CLK);
    rga: reg8
    port map ( REG_IN => s_mux_result1,
                LD => dec_0,
                CLK => invertedCLK,
                REG_OUT => ra_result );
    RA <= ra_result;
    rgb: reg8
    port map ( REG_IN => ra_result,
                LD => dec_1,
                CLK => invertedCLK,
                REG_OUT => rb_result );
    RB <= rb_result;
    m1: mux4t1
    port map ( D3 => X,
                D2 => Y,
                D1 => Z,
                D0 => rb_result,
                SEL => MS,
                MX_OUT => s_mux_result1);
    d1: the_1t2_decoder
    port map (  O => DS,
                D1 => dec_1,
                D0 => dec_0);

end Logic;
