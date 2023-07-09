create or replace package series#
IS
    function square_of_sums(in_number integer) return pls_integer;
    function sum_of_squares(in_number integer) return pls_integer;
    function diff_of_squares(in_number integer) return pls_integer;
end series#;
/

create or replace package body series#
IS
    function square_of_sums(
        in_number integer
    ) return pls_integer
    IS
        sub_total pls_integer := 0;
        o_result pls_integer := 0;
    BEGIN
        for i in 1 .. in_number
        LOOP
            sub_total := sub_total + i;
        END LOOP;

        if sub_total > 0
        then
            o_result := POWER(sub_total, 2);
        end if;

        return o_result;
    end square_of_sums;

    function sum_of_squares(
            in_number integer
    ) return pls_integer
    is
        sub_total pls_integer := 0;
        o_result pls_integer := 0;
    BEGIN
        for i in 1 .. in_number
        LOOP
            sub_total := POWER(i, 2);
            o_result := o_result + sub_total;
        END LOOP;

        return o_result;
    end sum_of_squares;

    function diff_of_squares(
        in_number integer
    ) return pls_integer
    IS
        o_result pls_integer := 0;
        sum_of_squares_in pls_integer :=0;
        square_of_sums_in pls_integer := 0;
    BEGIN
        sum_of_squares_in := sum_of_squares(in_number);
        square_of_sums_in := square_of_sums(in_number);
        o_result := (square_of_sums_in - sum_of_squares_in);
        return o_result;
    end diff_of_squares;

END series#;
/
