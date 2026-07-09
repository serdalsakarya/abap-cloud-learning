CLASS zcl_27_ex_11_constructor DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_27_ex_11_constructor IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA conn TYPE REF TO lcl_connection.
    DATA conns TYPE TABLE OF REF TO lcl_connection.

    TRY.
        conn = NEW #(
          i_carrier_id    = 'LH'
          i_connection_id = '0400'
        ).

        APPEND conn TO conns.
      CATCH cx_abap_invalid_value.
        out->write( 'Method call failed.' ).
    ENDTRY.

    TRY.
        CLEAR conn.
        conn = NEW #(
          i_carrier_id    = 'BA'
          i_connection_id = '0064'
        ).
        APPEND conn TO conns.
      CATCH cx_abap_invalid_value.
        out->write( 'Method call failed.' ).
    ENDTRY.

    TRY.
        CLEAR conn.
        conn = NEW #(
          i_carrier_id    = ''
          i_connection_id = '0064'
        ).
        APPEND conn TO conns.
      CATCH cx_abap_invalid_value.
        out->write( 'Method call failed.' ).
    ENDTRY.

    LOOP AT conns INTO conn.
      out->write( conn->get_output( ) ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
