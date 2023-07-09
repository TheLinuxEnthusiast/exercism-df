create or replace package complement#
is 
    function of_dna(in_string varchar2) return varchar2;
    function of_rna(in_string varchar2) return varchar2;
end complement#;
/

create or replace package body complement#
is
    function of_rna(
        in_string varchar2
    ) return varchar2
    is
        len integer;
        tmp varchar2(50);
        out_string varchar2(50);
    begin
        len := length(in_string);
        for i in 1 .. len
        LOOP
            tmp := SUBSTR(in_string, i ,1);
            if tmp = 'C' THEN
                out_string := out_string || 'G'; 
            elsif tmp = 'G' THEN
                out_string := out_string || 'C'; 
            elsif tmp = 'A' THEN
                out_string := out_string || 'T'; 
            else -- U
                out_string := out_string || 'A'; 
            end if;
        END LOOP;
        
        return out_string;
    end of_rna;
    
    function of_dna(
        in_string varchar2
    ) return varchar2
    is
        len integer;
        tmp varchar2(50);
        out_string varchar2(50);
    begin
        len := length(in_string);
        for i in 1 .. len
        LOOP
            tmp := SUBSTR(in_string, i ,1);
            if tmp = 'G' THEN
                out_string := out_string || 'C'; 
            elsif tmp = 'C' THEN
                out_string := out_string || 'G'; 
            elsif tmp = 'T' THEN
                out_string := out_string || 'A'; 
            else -- A
                out_string := out_string || 'U'; 
            end if;
        END LOOP;
        
        return out_string;
        
    end of_dna;
    
end complement#;
/
