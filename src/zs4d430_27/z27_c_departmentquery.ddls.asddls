@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Department (Query)'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z27_C_DEPARTMENTQUERY
  with parameters
    p_target_curr : /dmo/currency_code,
    @EndUserText.label: 'Date of evaluation'
    @Environment.systemField: #SYSTEM_DATE
    p_date        : abap.dats
  as select from Z27_C_EMPLOYEEQUERYP(
                 p_target_curr: $parameters.p_target_curr,
                 p_date: $parameters.p_date) as eq
                 right outer join Z27_R_Department as d
                 on eq.DepartmentId = d.Id
{
  key d.Id,
  d.Description,
  avg(eq.CompanyAffiliation as abap.dec(11,1)) as AverageAffiliation,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  sum(eq.AnnualSalaryConverted)                as TotalSalary,
  eq.CurrencyCode
}
group by
    d.Id,
    d.Description,
    eq.CurrencyCode


