----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2019 02:07:32 AM
-- Design Name: 
-- Module Name: q5 - Logic
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity q6 is
  Port (    A,B,C           : in std_logic_vector(7 downto 0);
            SEL1, SEL2, CLK   : in std_logic;
            RAP, RBP        : out std_logic_vector(7 downto 0));
end q6;

architecture Logic of q6 is
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
--signal invertedCLK  : std_logic;

begin

    --invertedCLK <= (NOT CLK);
    rga: reg8
    port map ( REG_IN => s_mux_result1,
                LD => dec_1,
                CLK => CLK,
                REG_OUT => RAP );
    rgb: reg8
    port map ( REG_IN => C,
                LD => dec_0,
                CLK => CLK,
                REG_OUT => RBP );
    m1: mux2t1
    port map ( top => A,
                bottom => B,
                SEL => SEL1,
                M_OUT => s_mux_result1);
    d1: the_1t2_decoder
    port map (  O => SEL2,
                D1 => dec_1,
                D0 => dec_0);

end Logic;
