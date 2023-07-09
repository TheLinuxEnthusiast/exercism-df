create or replace package binary#
is
    function to_decimal(binary_string VARCHAR2) return pls_integer;
end binary#;
/

create or replace package body binary#
is 
    function to_decimal(
        binary_string varchar2
    ) return pls_integer
    is
        out_decimal pls_integer := 0;
        temp_binary varchar2(200) := binary_string;
        regexp varchar2(200);
    begin

    regexp := regexp_substr(binary_string, '[01]*');
    if regexp is null or regexp != binary_string then
      return 0;
    end if;

    for i in 0 .. length(binary_string)-1 LOOP
        out_decimal := out_decimal + power(2, i) * to_number(substr(temp_binary, length(temp_binary)));
        temp_binary := substr(temp_binary, 1, length(temp_binary) - 1);
    end loop;

    return out_decimal;

    end;

END binary#;
/