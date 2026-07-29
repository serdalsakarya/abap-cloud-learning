INTERFACE zif_travel_status27
  PUBLIC .
methods:
CAN_PREPARE
importing iv_status TYPE z27de_status
RETURNING VALUE(rv_allowed) TYPE abap_bool,
CAN_BOOK
importing iv_status TYPE z27de_status
RETURNING VALUE(rv_allowed) TYPE abap_bool,
GET_STATUS_TEXT
importing iv_status TYPE z27de_status
RETURNING VALUE(rv_text) TYPE string.
ENDINTERFACE.
