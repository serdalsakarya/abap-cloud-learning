CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE Travel.

    METHODS bookTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~bookTravel RESULT result.

    METHODS prepareTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~prepareTravel RESULT result.

    METHODS setInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Travel~setInitialStatus.

    METHODS validateAgency FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateAgency.

    METHODS validateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateDates.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.
    LOOP AT entities INTO DATA(entity).

    APPEND VALUE #(
      %cid       = entity-%cid
      TravelUuid = cl_system_uuid=>create_uuid_x16_static( )
    ) TO mapped-Travel.

  ENDLOOP.

  ENDMETHOD.

  METHOD bookTravel.

    READ ENTITIES OF zr_travel27 IN LOCAL MODE
      ENTITY Travel
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
        RESULT DATA(travels).

    MODIFY ENTITIES OF zr_travel27 IN LOCAL MODE
      ENTITY Travel
        UPDATE FIELDS ( Status )
        WITH VALUE #(
          FOR travel IN travels
          WHERE ( Status = 'P' )
          (
            %tky   = travel-%tky
            Status = 'B'
          )
        ).

    READ ENTITIES OF zr_travel27 IN LOCAL MODE
      ENTITY Travel
        ALL FIELDS
        WITH CORRESPONDING #( keys )
        RESULT DATA(updated_travels).

    result = VALUE #(
      FOR travel IN updated_travels
      (
        %tky   = travel-%tky
        %param = travel
      )
    ).

  ENDMETHOD.

  METHOD prepareTravel.
    READ ENTITIES OF zr_travel27 IN LOCAL MODE
    ENTITY Travel
      FIELDS ( Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    MODIFY ENTITIES OF zr_travel27 IN LOCAL MODE
      ENTITY Travel
        UPDATE FIELDS ( Status )
        WITH VALUE #(
          FOR travel IN travels
          WHERE ( Status = 'N' )
          (
            %tky   = travel-%tky
            Status = 'P'
          )
        ).

    READ ENTITIES OF zr_travel27 IN LOCAL MODE
      ENTITY Travel
        ALL FIELDS
        WITH CORRESPONDING #( keys )
        RESULT DATA(updated_travels).

    result = VALUE #(
      FOR travel IN updated_travels
      (
        %tky   = travel-%tky
        %param = travel
      )
    ).
  ENDMETHOD.

  METHOD setInitialStatus.
    MODIFY ENTITIES OF zr_travel27 IN LOCAL MODE
     ENTITY Travel
       UPDATE FIELDS ( Status )
       WITH VALUE #(
         FOR key IN keys
         (
           %tky = key-%tky
           Status = 'N'
         )
       ).
  ENDMETHOD.

  METHOD validateAgency.
    READ ENTITIES OF zr_travel27 IN LOCAL MODE
     ENTITY Travel
       FIELDS ( AgencyId )
       WITH CORRESPONDING #( keys )
       RESULT DATA(travels).

    LOOP AT travels INTO DATA(travel).

      SELECT SINGLE FROM zi_agency27
        FIELDS AgencyID
        WHERE AgencyID = @travel-AgencyId
        INTO @DATA(agency).

      IF sy-subrc <> 0.

        APPEND VALUE #(
          %tky = travel-%tky
        ) TO failed-Travel.

        APPEND VALUE #(
          %tky = travel-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text = 'Agency does not exist'
          )
        ) TO reported-Travel.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD validateDates.
    READ ENTITIES OF zr_travel27 IN LOCAL MODE
      ENTITY Travel
        FIELDS ( BeginDate EndDate )
        WITH CORRESPONDING #( keys )
        RESULT DATA(travels).

    LOOP AT travels INTO DATA(travel).

      IF travel-EndDate < travel-BeginDate.

        APPEND VALUE #( %tky = travel-%tky )
          TO failed-Travel.

        APPEND VALUE #(
          %tky = travel-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text = 'End date cannot be before begin date'
          )
        )
        TO reported-Travel.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
