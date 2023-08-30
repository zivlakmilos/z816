library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg is
  port (
    D: in std_logic_vector(15 downto 0);
    ei: in std_logic;
    eo: in std_logic;
    clk: in std_logic;
    clr: in std_logic;

    q: out std_logic_vector(15 downto 0);
    dq: out std_logic_vector(15 downto 0)
  );
end reg;

architecture reg of reg is
  signal v: std_logic_vector(15 downto 0);
begin
  process(clk, clr, D, ei, eo, v)
  begin
    if clr = '1' then
      v <= "0000000000000000";
    elsif clk'event and clk = '1' and ei = '1' then
      v <= D;
    end if;

    q <= v and eo & eo & eo & eo & eo & eo & eo & eo & eo & eo & eo & eo & eo & eo & eo & eo;
    dq <= v;
  end process;
end reg;
