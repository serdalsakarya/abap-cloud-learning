*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_connection DEFINITION .

  PUBLIC SECTION.
    CLASS-DATA:  conn_counter TYPE i READ-ONLY.
    METHODS:
      get_output RETURNING VALUE(r_output) TYPE  string_table,
      constructor IMPORTING i_carrier_id    TYPE /dmo/carrier_id
                            i_connection_id TYPE /dmo/connection_id
                  RAISING   cx_abap_invalid_value.

    CLASS-METHODS class_constructor.


  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES:BEGIN OF st_details,
            airport_from_id TYPE /dmo/airport_from_id,
            airport_to_id   TYPE /dmo/airport_to_id,
            carrier_name    TYPE /dmo/carrier_name,
          END OF st_details.
    DATA: carrier_id    TYPE /dmo/carrier_id,
          connection_id TYPE /dmo/connection_id,
          details       TYPE st_details.

    TYPES:BEGIN OF st_airport,
            AirportID TYPE /dmo/airport_id,
            name      TYPE /dmo/airport_name,
          END OF st_airport.

    TYPES tt_airports TYPE STANDARD TABLE OF st_airport WITH NON-UNIQUE DEFAULT KEY.
    CLASS-DATA: airports TYPE tt_airports.



ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD get_output.
    APPEND |------------------------------| TO r_output.

    APPEND |Carrier: { carrier_id } ({ details-carrier_name }) | TO r_output.
    APPEND |Connection: { connection_id } | TO r_output.
    APPEND |Departure: { details-airport_from_id } ({ airports[ airportID = details-airport_from_id ]-name }) | TO r_output.
    APPEND |Destination: { details-airport_to_id } ({ airports[ airportID = details-airport_to_id ]-name }) | TO r_output.
  ENDMETHOD.

  METHOD constructor.
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.
    SELECT SINGLE FROM /dmo/I_connection
    FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
      WHERE AirlineID = @i_carrier_id AND ConnectionID = @i_connection_id
      INTO  @details.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.
    carrier_id = i_carrier_id.
    connection_id = i_connection_id.
    conn_counter += 1.
  ENDMETHOD.

  METHOD class_constructor.

    SELECT FROM /dmo/I_Airport
    FIELDS AirportID, Name
    INTO CORRESPONDING FIELDS OF TABLE @airports.
  ENDMETHOD.

ENDCLASS.
