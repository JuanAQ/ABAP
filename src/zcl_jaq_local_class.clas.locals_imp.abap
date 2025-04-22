*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_connection definition.

  public section.

  DATA carrier_id TYPE /DMO/CARRIER_ID.
  DATA connection_id TYPE /DMO/CONNECTION_ID.

  CLASS-DATA conn_counter TYPE i.

  METHODS set_attributes
    IMPORTING
    i_carrier_id TYPE /dmo/carrier_id DEFAULT 'LH'
    i_connection_id TYPE /dmo/connection_id

    RAISING
      cx_abap_invalid_value.

  METHODS get_attributes
    EXPORTING
    e_carrier_id TYPE /dmo/carrier_id
    e_connection_id TYPE /dmo/connection_id.

  protected section.
  private section.

endclass.

class lcl_connection implementation.

  method set_attributes.

    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    carrier_id = i_carrier_id.
    connection_id = i_connection_id.
    conn_counter = conn_counter + 1.

  endmethod.

  method get_attributes.

    e_carrier_id = carrier_id.
    e_connection_id = connection_id.

  endmethod.

endclass.
