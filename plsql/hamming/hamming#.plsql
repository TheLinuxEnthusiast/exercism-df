create or replace package hamming#
is
    function distance(i_first varchar2, i_second varchar2) return integer;
end hamming#;
/

create or replace package body hamming#
is
    function distance(
        i_first varchar2,
        i_second varchar2
    ) return integer
    is
        total integer := 0;
        len1 integer;
        len2 integer;
    begin
        len1 := length(i_first);
        len2 := length(i_second);
        if len1 = len2 then
            for i in 1 .. len1
            LOOP
                if SUBSTR(i_first, i, 1) != SUBSTR(i_second, i, 1) THEN
                    total := total + 1;
                end if;
            end LOOP;
        end if;
        
        return total;
    end distance;
    
end hamming#;
/
