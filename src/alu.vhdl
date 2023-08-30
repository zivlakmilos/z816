library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is
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
end alu;

architecture alu of alu is
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

  signal op: std_logic_vector(7 downto 0);
  signal sum: std_logic_vector(15 downto 0);
  signal sumc: std_logic;
  signal sumovf: std_logic;

  signal bx: std_logic_vector(15 downto 0);
begin
  op <= enand & enor & exor & eor & eand & enot & esub & eadd;
  bx <= b xor esub & esub & esub & esub & esub & esub & esub & esub & esub & esub & esub & esub & esub & esub & esub & esub;

  add: adder
  port map (
    x1 => a,
    x2 => bx,
    cx => '0',
    y => sum,
    cy => sumc,
    ovf => sumovf
  );

  process(op, a, bx, sum, sumc, sumovf)
  begin
    fz <= '0';
    fnz <= '0';
    fcf <= '0';
    fovf <= '0';

    case op is
      when "00000000" =>
        o <= "0000000000000000";
      when "00000001" =>
        o <= sum;
        fcf <= sumc;
        fovf <= sumovf;
      when "00000010" =>
        o <= sum;
        fcf <= sumc;
        fovf <= sumovf;
      when "00000100" =>
        o <= not a;
      when "00001000" =>
        o <= a and b;
      when "00010000" =>
        o <= a or b;
      when "00100000" =>
        o <= a xor b;
      when "01000000" =>
        o <= a nor b;
      when "10000000" =>
        o <= a nand b;
      when others =>
        o <= "0000000000000000";
    end case;

    if o = "0000000000000000" then
      fnz <= '1';
    else
      fz <= '1';
    end if;
  end process;
end alu;
