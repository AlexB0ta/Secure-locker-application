library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 
 
entity counter is 
  port(C,up,down,reset: in  std_logic;  
        Q : out std_logic_vector(3 downto 0));  
end counter; 

architecture archi of counter is  
  signal tmp: std_logic_vector(3 downto 0):="0000"; 
  begin  
      process (C,up,down) 
        begin  
        if reset='1' then
        	tmp<="0000";
        else
  		if up='1' and down='0' then
  			if (tmp="1111") then  
            		tmp <= "0000";  
            	elsif (C'event and C='1') then
            		tmp <= tmp + 1;
            	end if;
          elsif up='0' and down='1' then
            	if (tmp="0000") then  
            		tmp <= "1111";  
            	elsif (C'event and C='1') then
            		tmp <= tmp - 1;
            	end if;
          end if;
          end if;
      end process; 
      Q <= tmp;  
end archi; 
