@AbapCatalog.sqlViewName: 'ZV_TRAV_LOG_A223'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface - TRAVEL'
define root view Z_I_TRAVEL_LOG_A23
  as select from ztravel_log_a223 as Travel
    composition [0..*] of Z_I_BOOKING_LOG_A223 as _Booking
    association [0..1] to /DMO/I_Agency as _Agency on $projection.AgencyId = _Agency.AgencyID
    association [0..1] to /DMO/I_Customer as _Customer on $projection.CustomerId = _Customer.CustomerID
    association [0..1] to I_Currency as _Currency on $projection.CurrencyCode = _Currency.Currency
{

   key travel_id as TravelId,
        agency_id as AgencyId,
        customer_id as CustomerId,
        begin_date as BeginDate,
        end_date as EndDate,
        @Semantics.amount.currencyCode: 'CurrencyCode'
        booking_fee as BookingFee,
        @Semantics.amount.currencyCode: 'CurrencyCode'
        total_price as TotalPrice,
        @Semantics.currencyCode: true
        currency_code as CurrencyCode,
        description as Description,
        overall_status as OverallStatus,
        @Semantics.user.createdBy: true
        created_by as CreatedBy,
        @Semantics.systemDateTime.createdAt: true
        created_at as CreatedAt,
        @Semantics.user.lastChangedBy: true
        last_changed_by as LastChangedBy,
        @Semantics.systemDateTime.lastChangedAt: true
        last_change_at as LastChangeAt,
        _Booking,
        _Agency,
        _Customer,
        _Currency
       
}
