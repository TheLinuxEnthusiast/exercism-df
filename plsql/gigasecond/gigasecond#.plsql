create or replace package gigasecond#
is 
    function since(in_date DATE) return DATE;
end gigasecond#;
/

create or replace package body gigasecond#
is
    function since(
        in_date DATE
    ) return DATE
    is
        o_result DATE;
    begin
        o_result := in_date + NUMTODSINTERVAL(1000000000, 'SECOND');
        return to_DATE(to_char(o_result, 'YYYY-MM-DD'), 'YYYY-MM-DD');
    end since;

end gigasecond#;
/