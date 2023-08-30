library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity adder is
  port (
    x1: in std_logic_vector(15 downto 0);
    x2: in std_logic_vector(15 downto 0);
    cx: in std_logic;
    y: out std_logic_vector(15 downto 0);
    cy: out std_logic;
    ovf: out std_logic
  );
end adder;

architecture adder of adder is
  signal c: std_logic_vector(16 downto 0);
begin
  c(0) <= cx;
  y <= x1 xor x2 xor c(15 downto 0);
  c(16 downto 1) <= (x1 and x2) or (c(15 downto 0) and (x1 or x2));
  cy <= c(16);
  ovf <= c(16) xor c(15);
end adder;
