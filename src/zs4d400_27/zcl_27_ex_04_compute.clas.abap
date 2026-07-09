CLASS zcl_27_ex_04_compute DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_27_ex_04_compute IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  data: number1 type i,
        number2 type i.
        number1 = 50.
        number2 = 20.
data: result TYPE p LENGTH 8 DECIMALS 2.
        result =  number1 / number2 .

        DATA(output) = |{ number1 } / { number2 } = { result }|.
        out->write( output ).
        try.
            result =  number1 / 0 .
        CATCH cx_root into data(e).

        out->write( e->get_text( ) ).
        ENDTRY.

  ENDMETHOD.
ENDCLASS.
