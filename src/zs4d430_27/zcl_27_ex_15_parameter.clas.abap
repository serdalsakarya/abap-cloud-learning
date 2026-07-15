CLASS zcl_27_ex_15_parameter DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_27_ex_15_parameter IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT
*    FROM /LRN/C_Employee_Ann
      FROM z27_c_employeequeryp(
      p_target_curr = 'JPY',
      p_date = '20250101'
      )
    FIELDS employeeid,
           firstname,
           lastname,
           departmentid,

           departmentdescription,
           assistantname,
           \_department\_head-lastname AS headname,

           MonthlySalaryConverted,
          CurrencyCode,
          CompanyAffiliation

    INTO TABLE @DATA(result).

    out->write( result ).

  ENDMETHOD.
ENDCLASS.
