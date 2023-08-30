library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter is
  port (
    clk: in std_logic;
    clr: in std_logic;
    jmp: in std_logic;
    inc: in std_logic;
    eo: in std_logic;
    addr: in std_logic_vector(15 downto 0);

    q: out std_logic_vector(15 downto 0)
  );
end counter;

architecture counter of counter is
  component adder is
    port (
      x1: in std_logic_vector(15 downto 0);
      x2: in std_logic_vector(15 downto 0);
      cx: in std_logic;
      y: out std_logic_vector(15 downto 0);
      cy: out std_logic;
      ovf: out std_logic
    );
  end component;

  signal data: std_logic_vector(15 downto 0);
  signal sum: std_logic_vector(15 downto 0);
begin
  add: adder
  port map (
    x1 => data,
    x2 => "0000000000000001",
    cx => '0',
    y => sum
  );

  process(clr, clk, jmp, addr)
  begin
    if clr = '1' then
      data <= "0000000000000000";
    elsif clk'event and clk = '1' then
      if jmp = '1' then
        data <= addr;
      elsif inc = '1' then
        data <= sum;
      end if;
    end if;
  end process;

  q <= data and eo & eo & eo & eo & eo & eo & eo & eo & eo & eo & eo & eo & eo & eo & eo & eo;
end counter;
