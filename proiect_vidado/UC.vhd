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

ENTITY UC IS
  PORT (
  		up,down,reset,adauga_cifru : in std_logic;
    		clk : in std_logic;
    		introdus_3_LED : out std_logic;
    		cmp_3 : in std_logic;
    		introdu_caractere_LED,liber_ocupat_LED : out std_logic;
    		sel_afisor : out std_logic_vector (1 downto 0);
    		en_cmp1 : out std_logic
    		
    );
END UC;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF UC IS

type STATE_dai is (idle, dulap_liber, car_1, car_2, car_3,cifru_adaugat,dulap_ocupat, car_1_o, car_2_o, car_3_o,cifru_adaugat_o,verif);
signal STATE, NXSTATE: STATE_dai;
signal introdu_caractere,liber_ocupat,introdus_3: std_logic :='0';
BEGIN

UPDATE_STATE: process (Clk)
			begin
			if Clk'EVENT and Clk = '1' then
					STATE <= NXSTATE;
				end if;
			end process UPDATE_STATE;

TRANSITIONS: process (STATE,adauga_cifru,reset,cmp_3,liber_ocupat)
				
				begin
				case STATE is
					when idle => en_cmp1<='0';
								if liber_ocupat='1' then NXSTATE<=dulap_ocupat;
								else NXSTATE <= dulap_liber;
								end if;
					when dulap_liber => if adauga_cifru='1' then NXSTATE <= car_1;
							   else NXSTATE <= dulap_liber;
							   end if;
					when car_1 => sel_afisor<="00";
								if adauga_cifru='1' then NXSTATE <= car_2;
								 else NXSTATE <= car_1;
								 end if;
					when car_2 => sel_afisor<="01";
								if adauga_cifru='1' then NXSTATE <= car_3;
								 else NXSTATE <= car_2;
								 end if;
					when car_3 => sel_afisor<="10";
								if adauga_cifru='1' then NXSTATE <= cifru_adaugat;
								 else NXSTATE <= car_3;
								 end if;
					when cifru_adaugat =>  sel_afisor<="11";
								if reset='1' then NXSTATE <= dulap_liber;
								else NXSTATE <= dulap_ocupat;
								end if;
									
					when dulap_ocupat => if adauga_cifru='1' then NXSTATE <= car_1_o;
							   else NXSTATE <= dulap_ocupat;
							   end if;
					when car_1_o => sel_afisor<="00";
								if adauga_cifru='1' then NXSTATE <= car_2_o;
								 else NXSTATE <= car_1_o;
								 end if;
					when car_2_o => sel_afisor<="01";
								if adauga_cifru='1' then NXSTATE <= car_3_o;
								 else NXSTATE <= car_2_o;
								 end if;
					when car_3_o => sel_afisor<="10";
								if adauga_cifru='1' then NXSTATE <= cifru_adaugat_o;
								 else NXSTATE <= car_3_o;
								 end if;
					when cifru_adaugat_o => sel_afisor<="11";
								if reset='1' then NXSTATE <= dulap_ocupat;
								else NXSTATE <= verif;
								end if;
					when verif => 	en_cmp1<='1';
								if cmp_3='1' then NXSTATE <= dulap_liber;
									else NXSTATE <= dulap_ocupat;
									end if;						
				end case;
			end process;

			
Outputs: process (STATE,adauga_cifru,reset,cmp_3,liber_ocupat)
		begin


		case STATE is
					when idle => introdu_caractere_LED<='0' ; liber_ocupat_LED<='0'; introdus_3_LED<='0';
					when dulap_liber => introdu_caractere_LED<='1';en_cmp1<='0';
					when cifru_adaugat => if reset='0' then introdu_caractere_LED<='0';liber_ocupat_LED<='1';introdus_3_LED<='1';
									  else introdu_caractere_LED<='1';
									  end if;
					when dulap_ocupat => introdu_caractere_LED<='1';introdus_3_LED<='0';
					when cifru_adaugat_o => if reset='0' then introdu_caractere_LED<='0';introdus_3_LED<='1';
									 else introdu_caractere_LED<='1';
									 end if;
					when verif => 
								if cmp_3='1' then liber_ocupat_LED<='0';introdus_3_LED<='0';
								else liber_ocupat_LED<='1';introdus_3_LED<='0';
								END if;
					when others => introdus_3_LED<='0';
				end case;	
		end process;	


END TypeArchitecture;
