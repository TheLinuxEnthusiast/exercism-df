create or replace package grains#
is
  function at_square(n integer) return NUMBER;
  function total return NUMBER;
end grains#;
/

create or replace package body grains#
is
    function at_square(
        n integer
    ) return NUMBER
    is
        res NUMBER := 0;
        square_index integer;
    begin
        square_index := n - 1;
        res := POWER(2, square_index);
        return res;
    end at_square;
    
    function total return NUMBER
    is
        res NUMBER := 0;
        sub_total NUMBER := 0;
    begin
        for i in 1 .. 64
        LOOP
            sub_total := at_square(i);
            res := res + sub_total;
        END LOOP;
        return res;
    end total;
    
end grains#;
/
