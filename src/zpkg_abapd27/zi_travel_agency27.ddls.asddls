@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Link travel with agency'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_TRAVEL_AGENCY27 as select from ZR_TRAVEL27
{
    key TravelUuid,
    TravelId,
    AgencyId,
    BeginDate,
    EndDate,
    Description,
    Status,
    CreatedAt,
    CreatedBy,
    LastchangedAt,
    LastchangedBy,
    LocalLastChangedAt,
    
    _Agency
}
