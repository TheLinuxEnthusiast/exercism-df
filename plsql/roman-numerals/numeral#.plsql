create or replace package numeral#
is
    function to_roman(n integer) return varchar2;
    function convert_str(in_number integer, idx_num integer) return varchar2;
end numeral#;
/

create or replace package body numeral#
is
    function convert_str(
        in_number integer,
        idx_num integer
    ) return varchar2
    is
        tmp_result varchar2(254) := '';
        diff integer := 0;
    begin
        if idx_num = 1 --units
        THEN
            if in_number BETWEEN 1 AND 3
            THEN
                for i in 1 .. in_number
                LOOP
                    tmp_result := tmp_result || 'I';
                END LOOP;
            elsif in_number = 4
            THEN
                tmp_result := tmp_result || 'IV';
            elsif in_number = 5
            THEN
                tmp_result := tmp_result || 'V';
            elsif in_number BETWEEN 6 AND 8
            THEN
                diff := (in_number - 5);
                tmp_result := tmp_result || 'V';
                for i in 1 .. diff
                LOOP
                    tmp_result := tmp_result || 'I';
                END LOOP;
            elsif in_number = 9
            THEN
                tmp_result := tmp_result || 'IX';
            elsif in_number = 0
            THEN
                NULL;
            end if;
        elsif idx_num = 2 --tens
        THEN
            if in_number BETWEEN 1 AND 3
            THEN
                for i in 1 .. in_number
                LOOP
                    tmp_result := tmp_result || 'X';
                END LOOP;
            elsif in_number = 4
            THEN
                tmp_result := tmp_result || 'XL';
            elsif in_number = 5
            THEN
                tmp_result := tmp_result || 'L';
            elsif in_number BETWEEN 6 AND 8
            THEN
                diff := (in_number - 5);
                tmp_result := tmp_result || 'L';
                for i in 1 .. diff
                LOOP
                    tmp_result := tmp_result || 'X';
                END LOOP;
            elsif in_number = 9
            THEN
                tmp_result := tmp_result || 'XC';
            elsif in_number = 0
            THEN
                NULL;
            end if;
        elsif idx_num = 3 --hundreds
        THEN
            if in_number BETWEEN 1 AND 3
            THEN
                for i in 1 .. in_number
                LOOP
                    tmp_result := tmp_result || 'C';
                END LOOP;
            elsif in_number = 4
            THEN
                tmp_result := tmp_result || 'CD';
            elsif in_number = 5
            THEN
                tmp_result := tmp_result || 'D';
            elsif in_number BETWEEN 6 AND 8
            THEN
                diff := (in_number - 5);
                tmp_result := tmp_result || 'D';
                for i in 1 .. diff
                LOOP
                    tmp_result := tmp_result || 'C';
                END LOOP;
            elsif in_number = 9
            THEN
                tmp_result := tmp_result || 'CM';
            elsif in_number = 0
            THEN
                NULL;
            end if;
        elsif idx_num = 4 --thousands
        THEN
            if in_number BETWEEN 1 AND 3
            THEN
                for i in 1 .. in_number
                LOOP
                    tmp_result := tmp_result || 'M';
                END LOOP;
            end if;
        end if;
        
        return tmp_result;
        
    end convert_str;
    
    function to_roman(
        n integer
    ) return varchar2
    is
        str_input varchar2(254) := '';
        tmp_number integer;
        final_result varchar2(254) := '';
        len integer := 0;
        cnt integer := 0;
    begin
        str_input := TO_CHAR(n);
        len := length(str_input);
        
        -- e.g. 45, 4tens, 5units = XLV
        for i in REVERSE 1 .. len
        LOOP
            cnt := cnt + 1;
            tmp_number := TO_NUMBER(SUBSTR(str_input, i, 1));
            final_result := convert_str(tmp_number, cnt) || final_result; 
        END LOOP;
        
        return final_result;
    end to_roman;

end numeral#;
/
