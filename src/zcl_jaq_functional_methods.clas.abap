CLASS zcl_jaq_functional_methods DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_jaq_functional_methods IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA connection TYPE REF TO lcl_connection.
  DATA connections TYPE TABLE OF REF TO lcl_connection.

* Create instance

  TRY.

  connection = NEW #(
                      i_carrier_id = 'LH'
                      i_connection_id = '0400'
                    ).

*        connection->set_attributes(
*          EXPORTING
*            i_carrier_id    = 'LH'
*            i_connection_id = '0400'
*        ).


  CATCH cx_abap_invalid_value.
    out->write( `Method call failed` ).

  ENDTRY.

  APPEND connection TO connections.

* Calling Functional Method
**********************************************************************

  " in a value assignment (with inline declaration for result)
  DATA(result) = connection->get_output(  ).
  out->write( result ).

  " in logical expression
  IF connection->get_output(  ) IS NOT INITIAL.

    " as operand in a statement
    LOOP AT connection->get_output(  ) INTO DATA(line).

      out->write( line ).

    ENDLOOP.

    " to supply input parameter for another method
    out->write( data = connection->get_output( )
                name = ` ` ).

  ENDIF.




  ENDMETHOD.
ENDCLASS.
