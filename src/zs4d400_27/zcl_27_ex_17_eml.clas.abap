CLASS zcl_27_ex_17_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_27_ex_17_eml IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA agencies_upd TYPE TABLE FOR UPDATE /DMO/I_AgencyTP.
    agencies_upd = VALUE #( ( agencyid = '070027' name = 'fly high to see all' ) ).

    MODIFY ENTITIES OF /DMO/I_AgencyTP ENTITY /dmo/agency
    UPDATE FIELDS ( name )
    WITH agencies_upd.

    COMMIT ENTITIES.

    out->write( 'Method execution finished.' ).

      ENDMETHOD.
ENDCLASS.
