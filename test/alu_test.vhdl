library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_arith.all;

entity alu_test is
end alu_test;

architecture alu_test of alu_test is
  component alu is
    port (
      a: in std_logic_vector(15 downto 0);
      b: in std_logic_vector(15 downto 0);

      eadd: in std_logic;
      esub: in std_logic;
      enot: in std_logic;
      eand: in std_logic;
      eor: in std_logic;
      exor: in std_logic;
      enor: in std_logic;
      enand: in std_logic;

      fz: out std_logic;
      fnz: out std_logic;
      fcf: out std_logic;
      fovf: out std_logic;

      o: out std_logic_vector(15 downto 0)
    );
  end component;

  signal a: std_logic_vector(15 downto 0) := "1011101110111011";
  signal b: std_logic_vector(15 downto 0) := "0000000000000000";

  signal fz: std_logic := '0';
  signal fnz: std_logic := '0';
  signal fcf: std_logic := '0';
  signal fovf: std_logic := '0';

  signal o: std_logic_vector(15 downto 0) := "0000000000000000";

  signal opp: std_logic_vector(7 downto 0) := "00000000";
begin
  dut: alu
  port map (
    a => a,
    b => b,

    eadd => opp(0),
    esub => opp(1),
    enot => opp(2),
    eand => opp(3),
    eor => opp(4),
    exor => opp(5),
    enor => opp(6),
    enand => opp(7),

    fz => fz,
    fnz => fnz,
    fcf => fcf,
    fovf => fovf,

    o => o
  );

  process
  begin
    for i in 0 to 255 loop
      b <= conv_std_logic_vector(i, 16);
      for j in 0 to 7 loop
        opp <= "00000001" sll j;
        wait for 10 ns;
      end loop;
    end loop;
    wait;
  end process;
end alu_test;
