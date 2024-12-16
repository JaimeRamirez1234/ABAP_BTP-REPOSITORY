@AbapCatalog.sqlViewName: 'ZV_HCM_A223'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'HCM - Master'
@Metadata.ignorePropagatedAnnotations: true
define root view Z_I_HCM_MASTER
  as select from zhcm_master as HCMMaster
{
  key e_number,
      e_name,
      e_department,
      status,
      job_title,
      start_date,
      end_date,
      email,
      m_number,
      m_name,
      m_department,
      crea_date_time,
      crea_uname,
      lchg_date_time,
      lchg_uname

}
