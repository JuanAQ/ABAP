CLASS zcl_jaq_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_jaq_eml IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


  DATA agencies_upd TYPE TABLE FOR UPDATE /DMO/I_AgencyTP.

  agencies_upd = VALUE #( ( agencyid = '070035' name = 'Dos Hermanos' ) ).

  MODIFY ENTITIES OF /DMO/I_AgencyTP
            ENTITY /DMO/Agency
            UPDATE FIELDS ( name )
              WITH agencies_upd.

  out->write( `Method execution finished!` ).

  COMMIT ENTITIES.

  ENDMETHOD.
ENDCLASS.
