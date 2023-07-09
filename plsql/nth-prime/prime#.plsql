create or replace package prime#
is  
    invalid_argument_error exception;
    function nth(pr pls_integer) return pls_integer;
    function is_prime(pr pls_integer) return integer;
end prime#;
/


create or replace package body prime#
is
    function is_prime(
        pr pls_integer
    ) return integer
    is
        cnt integer := 0;
    begin
        if pr = 1
        THEN
            return 1;
        end if;
    
        for i in 1 .. pr
        LOOP
            if MOD(pr, i) = 0
            THEN
                cnt := cnt + 1;
            END IF;
        END LOOP;
        
        if cnt = 2
        THEN
            return 0;
        else
            return 1;
        END IF;
    end is_prime;
    
    function nth(
        pr pls_integer
    ) return pls_integer
    is
        cnt pls_integer := 0;
        num pls_integer := 1;
        --invalid_argument_error EXCEPTION;
        current_prime pls_integer;
    begin
        if pr = 0
        THEN
            RAISE invalid_argument_error;
        END IF;
    
        WHILE TRUE
        LOOP
            if cnt = pr
            THEN
                return current_prime;
            END IF;
            
            if is_prime(num) = 0
            THEN
                current_prime := num;
                cnt := cnt + 1;
            END IF;
            num := num + 1;
        END LOOP;
    end nth;
end prime#;
/
