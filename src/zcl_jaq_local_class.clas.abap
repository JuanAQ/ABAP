CLASS zcl_jaq_local_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_jaq_local_class IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA carrier_id TYPE /dmo/carrier_id.
  DATA connection_id TYPE /dmo/connection_id.

  DATA connection TYPE REF TO lcl_connection.
  DATA connections TYPE TABLE OF REF TO lcl_connection.

* First Instance
**********************************************************************

  connection = NEW #(  ).

  connection->set_attributes(
    EXPORTING
    i_carrier_id = 'LH'
    i_connection_id = '0400' ).

  APPEND connection TO connections.

* Second Instance
**********************************************************************

  connection = NEW #(  ).

  connection->set_attributes(
    EXPORTING
    i_carrier_id = 'NH'
    i_connection_id = '0500' ).

  APPEND connection TO connections.

* Third Instance
**********************************************************************

  connection = NEW #(  ).

  connection->set_attributes(
    EXPORTING
    i_carrier_id = 'JT'
    i_connection_id = '0600' ).

  APPEND connection TO connections.

* LOOP and print values

  LOOP AT connections INTO connection.

    connection->get_attributes(
      IMPORTING
      e_carrier_id = carrier_id
      e_connection_id = connection_id ).

    out->write( |Flight status: { carrier_id } { connection_id }| ).

  ENDLOOP.


* Raising Error
**********************************************************************

  CONSTANTS c_carrier_id TYPE /dmo/carrier_id VALUE 'LH'.
  CONSTANTS c_connection_id TYPE /dmo/connection_id VALUE '0700'.

* Create instance
**********************************************************************

  connection = NEW #(  ).

* Call Method and Handle Exception
**********************************************************************
  out->write( |i_carrier_id = '{ c_carrier_id }'| ).
  out->write( |i_connection_id = '{ c_connection_id }'| ).

  TRY.

    connection->set_attributes(
      EXPORTING
        i_carrier_id = c_carrier_id
        i_connection_id = c_connection_id
    ).

    APPEND connection TO connections.
    out->write( `Method call successful` ).
  CATCH cx_abap_invalid_value.
    out->write( `Method call failed` ).
  ENDTRY.

  ENDMETHOD.
ENDCLASS.
