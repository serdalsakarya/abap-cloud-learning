CLASS zcl_27_ex_01_intro DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_27_ex_01_intro IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  DATA var type /LRN/S4D430_IND_CDS_View.
  select from /LRN/S4D430_INd fields * into table @data(result).
  ENDMETHOD.
ENDCLASS.
