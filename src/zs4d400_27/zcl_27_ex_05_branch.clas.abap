CLASS zcl_27_ex_05_branch DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_27_ex_05_branch IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Declarations
**************************

    DATA number1 TYPE i.
    DATA number2 TYPE i.
    DATA op TYPE c VALUE '/'.
    DATA result TYPE p LENGTH 8 DECIMALS 2.
    DATA output TYPE string.


* Input Values
**************************

    number1 = 1.
    number2 = 0.

* Calculation
*************************
    CASE op.
      WHEN '+'.
        result = number1 + number2.

      WHEN '-'.
        result = number1 - number2.

      WHEN '*'.
        result = number1 * number2.

      WHEN '/'.
        TRY.
            result = number1 / number2.
          CATCH cx_root INTO DATA(e).
            output = |Error: { e->get_text(  ) }|.
            CLEAR result.
        ENDTRY.
      WHEN OTHERS.
        output = 'Wrong operator'.
    ENDCASE.
    IF output IS INITIAL.
      output = |{ number1 } { op } { number2 } = { result }|.
    ENDIF.

* Output
**************************

    out->write( output ).

  ENDMETHOD.
ENDCLASS.
