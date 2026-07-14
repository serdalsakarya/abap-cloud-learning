@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee (Query)'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z27_C_EMPLOYEEQUERY
  as select from Z27_R_EMPLOYEE
{
  key EmployeeId,
      FirstName,
      LastName,
      DepartmentId,
      _Department.Description as DepartmentDescription,
      _Department._Assistant.LastName as Assistantname,
      /* Associations */
      _Department
}
