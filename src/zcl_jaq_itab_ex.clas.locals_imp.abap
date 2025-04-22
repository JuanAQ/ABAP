*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_connection definition.

  public section.

    CLASS-DATA conn_counter TYPE i READ-ONLY.

    CLASS-METHODS class_constructor.

* Constructor
  METHODS constructor
    IMPORTING
      i_carrier_id TYPE /dmo/carrier_id
      i_connection_id TYPE /dmo/connection_id
    RAISING
      cx_ABAP_INVALID_VALUE.

* Get output
  METHODS get_output
    RETURNING VALUE(r_output) TYPE string_table.

**********************************************************************
* Protected section
  protected section.

**********************************************************************
* Private Section
  private section.

  TYPES:
      BEGIN OF st_details,
        DepartureAirport   TYPE /dmo/airport_from_id,
        DestinationAirport TYPE /dmo/airport_to_id,
        AirlineName        TYPE   /dmo/carrier_name,
      END OF st_details.

  TYPES:
      BEGIN OF st_airport,
        AirportID TYPE /dmo/airport_id,
        Name      TYPE /dmo/airport_name,
      END OF st_airport.

  TYPES tt_airports TYPE STANDARD TABLE OF st_airport
                        WITH NON-UNIQUE DEFAULT KEY.

  DATA carrier_id TYPE /DMO/CARRIER_ID.
  DATA connection_id TYPE /DMO/CONNECTION_ID.

  DATA details TYPE st_details.

  CLASS-DATA airports TYPE tt_airports.

endclass.

class lcl_connection implementation.

  method class_constructor.

    SELECT FROM /DMO/I_Airport
          FIELDS AirportID, Name
            INTO TABLE @airports.

  endmethod.

method constructor.

    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_ABAP_INVALID_VALUE.
    ENDIF.

    SELECT SINGLE
      FROM /DMO/I_CONNECTION
      FIELDS DepartureAirport, DestinationAirport, \_Airline-Name as AirlineName
      WHERE AirlineID = @i_carrier_id
      AND ConnectionID = @i_connection_id
      INTO CORRESPONDING FIELDS OF @details.


    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    me->carrier_id = i_carrier_id.
    me->connection_id = i_connection_id.

    conn_counter = conn_counter + 1.

endmethod.


method get_output.

    DATA(departure) = airports[ airportID = details-departureairport ].
    DATA(destination) = airports[ airportID = details-destinationairport ].


    APPEND |--------------------------------|                    TO r_output.
    APPEND |Carrier:     { carrier_id } { details-airlinename }| TO r_output.
    APPEND |Connection:  { connection_id   }|                    TO r_output.
    APPEND |Departure:   { details-departureairport   } { departure-name   }| TO r_output.
    APPEND |Destination: { details-destinationairport } { destination-name }| TO r_output.

endmethod.




endclass.
