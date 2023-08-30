library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_arith.all;

entity reg_test is
end reg_test;

architecture reg_test of reg_test is
  component reg is
    port (
      D: in std_logic_vector(15 downto 0);
      ei: in std_logic;
      eo: in std_logic;
      clk: in std_logic;
      clr: in std_logic;

      q: out std_logic_vector(15 downto 0);
      dq: out std_logic_vector(15 downto 0)
    );
  end component;

  signal D: std_logic_vector(15 downto 0) := "0000000000000000";
  signal ei: std_logic := '0';
  signal eo: std_logic := '0';
  signal clk: std_logic := '0';
  signal clr: std_logic := '0';

  signal q: std_logic_vector(15 downto 0) := "0000000000000000";
  signal dq: std_logic_vector(15 downto 0) := "0000000000000000";
begin
  r: reg
  port map (
    D => D,
    ei => ei,
    eo => eo,
    clk => clk,
    clr => clr,

    q => q,
    dq => dq
  );

  process
  begin
    clr <= '1';
    wait for 5 ns;
    clr <= '0';

    for i in 0 to 255 loop
      clk <= '0';
      D <= conv_std_logic_vector(i, 16);
      wait for 2 ns;
      ei <= '1';
      wait for 2 ns;
      clk <= '1';
      wait for 2 ns;
      D <= "0000000000000000";
      clk <= '0';
      ei <= '0';
      eo <= '1';
      wait for 2 ns;
      eo <= '1';
      wait for 2 ns;
      clk <= '1';
      wait for 2 ns;
      clk <= '0';
      eo <= '0';
    end loop;

    wait;
  end process;
end reg_test;
