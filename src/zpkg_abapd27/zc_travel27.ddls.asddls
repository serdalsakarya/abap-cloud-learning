@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection view entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_TRAVEL27 as projection on ZR_TRAVEL27
{
    key TravelUuid,
    @UI.lineItem: [{ position: 10, label: 'Travel ID' }]
    TravelId,

    @UI.lineItem: [{ position: 20, label: 'Agency ID' }]
    AgencyId,

    @UI.lineItem: [{ position: 30, label: 'Begin Date' }]
    BeginDate,

    @UI.lineItem: [{ position: 40, label: 'End Date' }]
    EndDate,

    @UI.lineItem: [{ position: 50, label: 'Description' }]
    Description,

    @UI.lineItem: [{ position: 60, label: 'Status' }]
    Status,
    CreatedAt,
    CreatedBy,
    LastchangedAt,
    LastchangedBy,
    LocalLastChangedAt,
    
    _Agency
}
