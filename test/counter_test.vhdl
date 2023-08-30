library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_arith.all;

entity counter_test is
end counter_test;

architecture counter_test of counter_test is
  component counter is
    port (
      clk: in std_logic;
      clr: in std_logic;
      jmp: in std_logic;
      inc: in std_logic;
      eo: in std_logic;
      addr: in std_logic_vector(15 downto 0);

      q: out std_logic_vector(15 downto 0)
    );
  end component;

  signal clk: std_logic := '0';
  signal clr: std_logic := '0';
  signal jmp: std_logic := '0';
  signal inc: std_logic := '0';
  signal eo: std_logic := '0';
  signal addr: std_logic_vector(15 downto 0) := "0000000000000000";

  signal q: std_logic_vector(15 downto 0) := "0000000000000000";
begin
  dut: counter
  port map (
    clk => clk,
    clr => clr,
    jmp => jmp,
    inc => inc,
    eo => eo,
    addr => addr,

    q => q
  );

  clk <= not clk after 10 ns;

  process
  begin
    eo <= '1';
    clr <= '1';
    inc <= '1';
    wait for 2 ns;
    clr <= '0';
    wait for 3 ns;
    wait for 100 ns;
    eo <= '0';
    addr <= "1000000000000000";
    jmp <= '1';
    wait for 10 ns;
    jmp <= '0';
    wait for 10 ns;
    addr <= "0000000000000000";
    eo <= '1';
    wait for 100 ns;
    inc <= '0';
    wait for 100 ns;
    inc <= '1';

    wait;
  end process;
end counter_test;
