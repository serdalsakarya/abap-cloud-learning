CLASS zcl_27_ex_09_instances DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_27_ex_09_instances IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA conn TYPE REF TO lcl_connection.
    DATA conns TYPE TABLE of REF to lcl_connection.

    conn = new #( ).
    conn->carrier_id = 'LH'.
    conn->connection_id = '0400'.
    APPEND conn to conns.

    clear conn.
    conn = new #( ).
    conn->carrier_id = 'BA'.
    conn->connection_id = '0064'.
    APPEND conn to conns.

    clear conn.
    conn = new #( ).
    conn->carrier_id = 'UA'.
    conn->connection_id = '093'.
    APPEND conn to conns.

    out->write( conns ).

  ENDMETHOD.
ENDCLASS.
