CLASS zcl_jaq_compute DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_jaq_compute IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Declarations
**********************************************************************

  DATA number1 TYPE i.
  DATA number2 TYPE i.

* Input Values
**********************************************************************

  number1 = -2.
  number2 = 5.

* Calculation
**********************************************************************

  DATA result TYPE p LENGTH 8 DECIMALS 2.

  result = number1 / number2.

  DATA(output) = |{ number1 } / { number2 } = { result }|.

* Output
**********************************************************************

  out->write( output ).


  ENDMETHOD.
ENDCLASS.
