@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'for some evaluations'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_TRAVEL_ANALYTICS27 as select from ZR_TRAVEL27
{
//    key TravelUuid,
//    TravelId,
AgencyId,
    
//    BeginDate,
//    EndDate,
//    Description,
Status,
    count(*) as TravelCount,
    min(BeginDate) as EarliestBeginDate,
    max(EndDate) as LatestEndDate
//    CreatedAt,
//    CreatedBy,
//    LastchangedAt,
//    LastchangedBy,
//    LocalLastChangedAt
}
group by AgencyId, Status
