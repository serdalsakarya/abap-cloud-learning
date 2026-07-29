CLASS zcl_travel_data_load27 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_travel_data_load27 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    " Travels


    DELETE FROM /dmo/d_travel_d.                        "#EC CI_NOWHERE
    DELETE FROM ztravel27.                              "#EC CI_NOWHERE

    INSERT ztravel27 FROM (
      SELECT FROM /dmo/travel FIELDS
        " client
        uuid( ) AS travel_uuid,
        travel_id,
        agency_id,
*        customer_id,
        begin_date,
        end_date,
*        booking_fee,
*        total_price,
*        currency_code,
        description,
        status,
        createdat AS created_at,
        createdby AS created_by,
        lastchangedat AS last_changed_at,
        lastchangedby AS last_changed_by,
        lastchangedat AS local_last_changed_at
        WHERE status <> 'X'
    ).
    IF sy-subrc = 0.
      out->write( | --> ZTRAVEL27 is filled(with { sy-dbcnt } rows) successfully. | ).
    ENDIF.
    RETURN.
    " bookings
    out->write( ' --> /DMO/A_BOOKING_D' ).

    DELETE FROM /dmo/d_booking_d.                       "#EC CI_NOWHERE
    DELETE FROM /dmo/a_booking_d.                       "#EC CI_NOWHERE

    INSERT /dmo/a_booking_d FROM (
        SELECT
          FROM /dmo/booking
            JOIN /dmo/a_travel_d ON /dmo/booking~travel_id = /dmo/a_travel_d~travel_id
            JOIN /dmo/travel ON /dmo/travel~travel_id = /dmo/booking~travel_id
          FIELDS  "client,
                  uuid( ) AS booking_uuid,
                  /dmo/a_travel_d~travel_uuid AS parent_uuid,
                  /dmo/booking~booking_id,
                  /dmo/booking~booking_date,
                  /dmo/booking~customer_id,
                  /dmo/booking~carrier_id,
                  /dmo/booking~connection_id,
                  /dmo/booking~flight_date,
                  /dmo/booking~flight_price,
                  /dmo/booking~currency_code,
                  CASE /dmo/travel~status WHEN 'P' THEN 'N'
                                                   ELSE /dmo/travel~status END AS booking_status,
                  /dmo/a_travel_d~last_changed_at AS local_last_changed_at
    ).



    " Booking supplements
    out->write( ' --> /DMO/A_BKSUPPL_D' ).

    DELETE FROM /dmo/d_bksuppl_d.                       "#EC CI_NOWHERE
    DELETE FROM /dmo/a_bksuppl_d.                       "#EC CI_NOWHERE

    INSERT /dmo/a_bksuppl_d FROM (
      SELECT FROM /dmo/book_suppl    AS supp
               JOIN /dmo/a_travel_d  AS trvl ON trvl~travel_id = supp~travel_id
               JOIN /dmo/a_booking_d AS book ON book~parent_uuid = trvl~travel_uuid
                                            AND book~booking_id = supp~booking_id

        FIELDS
          " client
          uuid( )                 AS booksuppl_uuid,
          trvl~travel_uuid        AS root_uuid,
          book~booking_uuid       AS parent_uuid,
          supp~booking_supplement_id,
          supp~supplement_id,
          supp~price,
          supp~currency_code,
          trvl~last_changed_at    AS local_last_changed_at
    ).

  ENDMETHOD.
ENDCLASS.
