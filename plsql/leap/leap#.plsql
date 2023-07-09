create or replace package year#
is
    function is_leap(yr integer) return varchar2;
end year#;
/


create or replace package body year#
is
    function is_leap(
        yr integer
    ) return varchar2
    is
        res varchar2(50) := '';
        mod_4 integer;
        mod_400 integer;
        mod_100 integer;
    begin
        mod_4 := MOD(yr, 4);
        mod_400 := MOD(yr, 400);
        mod_100 := MOD(yr, 100);
        if mod_4 = 0 AND mod_100 = 0 AND mod_400 = 0 
        THEN
            res := 'Yes, ' || TO_CHAR(yr) || ' is a leap year';
        elsif mod_100 = 0 AND mod_4 = 0
        THEN
            res := 'No, ' || TO_CHAR(yr) || ' is not a leap year';
        elsif mod_4 = 0
        THEN
            res := 'Yes, ' || TO_CHAR(yr) || ' is a leap year';
        else
            res := 'No, ' || TO_CHAR(yr) || ' is not a leap year';
        end if;
        
        return res;
        
    end is_leap;
end year#;
/
