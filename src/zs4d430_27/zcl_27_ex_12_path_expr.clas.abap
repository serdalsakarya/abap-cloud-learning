CLASS zcl_27_ex_12_path_expr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_27_EX_12_PATH_EXPR IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT
    FROM Z27_C_EMPLOYEEQUERY
    FIELDS employeeid,
           firstname,
           lastname,
           departmentid,
           DepartmentDescription,
           Assistantname,
           \_department\_Head-LastName as HeadName
    INTO TABLE @DATA(result).

    out->write( result ).

  ENDMETHOD.
ENDCLASS.
