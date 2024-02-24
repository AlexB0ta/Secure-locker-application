--------------------------------------------------------------------------------
-- Project :
-- File    :
-- Autor   :
-- Date    :
--
--------------------------------------------------------------------------------
-- Description :
--
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY cifru IS
  PORT (
  		cif : in std_logic_vector (3 downto 0);
		sel : in std_logic_vector (1 downto 0);
		mode : in  std_logic;
		en_cmp : in std_logic;
		rez : out std_logic;
		cif1_a,cif2_a,cif3_a : out std_logic_vector (3 downto 0) --cif pt afisat
    );
END cifru;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF cifru IS
signal cif1_c,cif2_c,cif3_c: std_logic_vector (3 downto 0); -- cif curente
signal cif1,cif2,cif3: std_logic_vector (3 downto 0); -- cif din dulap


BEGIN

process (en_cmp,mode,sel,cif)
begin
	if en_cmp='0' then
		if mode='0' then --introducem cod
			case sel is
				when "00"=> cif1<=cif;
				when "01"=> cif2<=cif;
				when "10"=> cif3<=cif;
				when others => rez<='0';
			end case;
		else 
			case sel is
				when "00"=> cif1_c<=cif;
				when "01"=> cif2_c<=cif;
				when "10"=> cif3_c<=cif;
				when others => rez<='0';
			end case;
		end if;
	else 
		if cif1=cif1_c and cif2=cif2_c and cif3=cif3_c then
			rez<='1';
		else
			rez<='0';
		end if;
	end if;
	cif1_a<=cif1;	cif2_a<=cif2;	cif3_a<=cif3;
end process;
END TypeArchitecture;
