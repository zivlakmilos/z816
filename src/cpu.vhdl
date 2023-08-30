library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cpu is
  port (
    clk: in std_logic;
    clr: in std_logic;
    hlt: out std_logic
  );
end cpu;

architecture cpu of cpu is
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

  signal data: std_logic_vector(15 downto 0);

  signal adata: std_logic_vector(15 downto 0);
  signal bdata: std_logic_vector(15 downto 0);

  signal ai: std_logic;
  signal ao: std_logic;
  signal bi: std_logic;
  signal bo: std_logic;

  signal pcjmp: std_logic;
  signal pcinc: std_logic;
  signal pco: std_logic;
begin
  a: reg
  port map (
    D => data,
    q => data,
    dq => adata,
    clk => clk,
    clr => clr,
    ei => ai,
    eo => ao
  );
  b: reg
  port map (
    D => data,
    q => data,
    dq => adata,
    clk => clk,
    clr => clr,
    ei => bi,
    eo => bo
  );
  /*
  mar: reg
  port map (
  );
  mvr: reg
  port map (
  );
  ins: reg
  port map (
  );
  */

  pc: counter
  port map (
    clk => clk,
    clr => clr,
    jmp => pcjmp,
    inc => pcinc,
    eo => pco,
    addr => data,

    q => data
  );

  hlt <= '0';
end cpu;
