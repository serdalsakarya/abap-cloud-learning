@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'agency cds view entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_AGENCY27 as select from /dmo/agency
//association [1..*] to ztravel27 as _Travel on $projection.AgencyID = _Travel.agency_id
{
    key agency_id as AgencyID,
    name as Name,
    city as City,
    country_code as CountryCode,
    phone_number as PhoneNumber,
    email_address as EmailAddress,
    web_address as WebAddress
//    _Travel
}
