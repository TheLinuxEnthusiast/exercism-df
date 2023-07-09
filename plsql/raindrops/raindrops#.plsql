create or replace package raindrops#
is
    function convert(n pls_integer) return varchar2;
end raindrops#;
/

create or replace package body raindrops#
is
    function convert(
        n pls_integer
    ) return varchar2
    is
        res varchar2(50) := '';
    begin
        if MOD(n, 3) = 0
        THEN
            res := res || 'Pling';
        end if;
        
        if MOD(n, 5) = 0
        THEN
            res := res || 'Plang';
        end if;
        
        if MOD(n, 7) = 0
        THEN
            res := res || 'Plong';
        end if;
        
        if length(res) IS NULL
        THEN
            res := res || TO_CHAR(n);
        end if;
        return res;
    end convert;
end raindrops#;
/
