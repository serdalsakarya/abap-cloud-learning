CLASS zcl_27_iterate DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_27_iterate IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    CONSTANTS count TYPE i VALUE 20.

    DATA gv_numbers TYPE TABLE OF i.
data gv_output TYPE table of string.
    DO count TIMES.
      CASE sy-index.
        WHEN 1.
          APPEND 1 TO gv_numbers.
        WHEN 2.
          APPEND 1 TO gv_numbers.
        WHEN OTHERS.
          APPEND gv_numbers[ sy-index - 1 ] + gv_numbers[ sy-index - 2 ] TO gv_numbers.
      ENDCASE.
    ENDDO.

    LOOP AT gv_numbers into data(lv_number).
    append |{ sy-tabix width = 4 align = left } ; { lv_number width = 10 align = right }| to gv_output.
    ENDLOOP.

    out->write(
      EXPORTING
        data   = gv_output
        name   = |The first { count } Fibonacci Numbers|
    ).


  ENDMETHOD.
ENDCLASS.
