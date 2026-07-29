CLASS zcl_travel_eml27 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_travel_eml27 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    MODIFY ENTITIES OF zr_travel27
    ENTITY Travel
    CREATE
    FIELDS ( AgencyId BeginDate EndDate Description )
    WITH VALUE #(
      (
        %cid = 'TRAVEL1'
        AgencyId = '070033'
        BeginDate = '20260728'
        EndDate = '20260730'
        Description = 'EML Test Travel'
      )
    )
    MAPPED DATA(mapped)
    FAILED DATA(failed)
    REPORTED DATA(reported).
    COMMIT ENTITIES.
    out->write( mapped ).
    out->write( failed ).
    out->write( reported ).
  ENDMETHOD.
ENDCLASS.
