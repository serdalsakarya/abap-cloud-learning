@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'root view entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_TRAVEL27
  as select from ztravel27
  association [1..1] to ZI_AGENCY27 as _Agency on $projection.AgencyId = _Agency.AgencyID
{
  key travel_uuid           as TravelUuid,
      travel_id             as TravelId,
      agency_id             as AgencyId,
      begin_date            as BeginDate,
      end_date              as EndDate,
      description           as Description,
      status                as Status,
      created_at            as CreatedAt,
      created_by            as CreatedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchanged_at        as LastchangedAt,
      lastchanged_by        as LastchangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      _Agency
}
