@ObjectModel.usageType:{
serviceQuality: #D,
  sizeCategory: #M,
  dataClass: #MASTER
}
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee (Consumption)'
//@Metadata.ignorePropagatedAnnotations: true
define view entity Z27_C_EMPLOYEE
  as select from Z27_R_EMPLOYEE
{
  key EmployeeId,
      FirstName,
      LastName,
      BirthDate,
      EntryDate,
      DepartmentId,
      //@Semantics.amount.currencyCode: 'CurrencyCode'
      AnnualSalary,
      CurrencyCode,
      CreatedBy,
      CreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt
}
