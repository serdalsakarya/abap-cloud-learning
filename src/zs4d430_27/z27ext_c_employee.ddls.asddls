extend view entity Z27_C_EMPLOYEEQUERYP with
association [1..1] to I_Country as _ZZCountryZem on $projection.ZZCountrZem = _ZZCountryZem.Country
{
  Employee.ZZTitelZem,
  Employee.ZZCountrZem,

  @EndUserText.label: 'Full Name'
  concat_with_space(
  Employee.FirstName,
  Employee.LastName,1
  )                                   as ZZFullNameZem,

  _ZZCountryZem.IsEuropeanUnionMember as ZZEUBasedZem
}
