@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Department (Entity)'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z27_R_Department
  as select from z27depment
  association [*] to Z27_R_EMPLOYEE as _Employee on $projection.Id = _Employee.DepartmentId
  association [0..1] to Z27_R_EMPLOYEE as _Head on $projection.HeadId = _Head.EmployeeId
  association [1] to Z27_R_EMPLOYEE as _Assistant on $projection.AssistantId  = _Assistant.EmployeeId
{
  key id                    as Id,
      description           as Description,
      department_head       as HeadId,
      department_assistant  as AssistantId,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      local_last_changed_by as LocalLastChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt,
      _Employee,
      _Head,
      _Assistant
}
