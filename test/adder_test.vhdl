library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_arith.all;

entity adder_test is
end adder_test;

architecture adder_test of adder_test is
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

  signal x1: std_logic_vector(15 downto 0) := "1011101110111011";
  signal x2: std_logic_vector(15 downto 0) := "0000000000000000";
  signal cx: std_logic := '0';
  signal y: std_logic_vector(15 downto 0) := "0000000000000000";
  signal cy: std_logic := '0';
  signal ovf: std_logic := '0';
begin
  add: adder
  port map (
    x1 => x1,
    x2 => x2,
    cx => cx,
    y => y,
    cy => cy,
    ovf => ovf
  );

  process
  begin
    for i in 0 to 255 loop
      x2 <= conv_std_logic_vector(i, 16);
      wait for 10 ns;
    end loop;
    wait;
  end process;
end adder_test;
