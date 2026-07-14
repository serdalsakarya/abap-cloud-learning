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
      _Department.Description  as DepartmentDescription,
      division(
      dats_days_between(EntryDate, $session.system_date), 365,1
      )                        as CompanyAffiliation,
      //      _Department._Assistant.LastName as Assistantname,
      concat_with_space(
      _Department._Assistant.FirstName, _Department._Assistant.LastName, 1
      )                        as Assistantname,

      @EndUserText.label: 'Employee Role'
      case EmployeeId
      when  _Department.HeadId then 'H'
      when  _Department.AssistantId then 'A'
      else ' ' end             as EmployeeRole,
      cast('USD' as abap.cuky) as CurrencyCodeUSD,

      @EndUserText.label: 'Annual Salary'
      @Semantics.amount.currencyCode: 'CurrencyCodeUSD'
      currency_conversion(
      amount => AnnualSalary,
      source_currency => CurrencyCode,
      target_currency => $projection.CurrencyCodeUSD,
      exchange_rate_date => $session.system_date
      )                        as AnnualSalaryConverted,

      @EndUserText.label: 'Monthly Salary'
      @Semantics.amount.currencyCode: 'CurrencyCodeUSD'
      cast($projection.AnnualSalaryConverted as abap.fltp)
      / 12.0                   as MonthlySalaryConverted,

      /* Associations */
      _Department
}
