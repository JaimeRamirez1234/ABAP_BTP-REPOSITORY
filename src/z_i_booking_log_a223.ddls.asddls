@AbapCatalog.sqlViewName: 'ZVBOOK_LOG_A223'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface - Booking'
@Metadata.ignorePropagatedAnnotations: true
define view Z_I_BOOKING_LOG_A223
  as select from zbooking_log_a23 as Booking
       composition [0..*] of Z_I_BOOKSUPPL_LOG_A223 as _BoookingSupplement
       association to parent Z_I_TRAVEL_LOG_A23 as _Travel on $projection.TravelId = _Travel.TravelId
       association [1..1] to /DMO/I_Customer as _Customer on $projection.CustomerId = _Customer.CustomerID
       association [1..1] to /DMO/I_Carrier as _Carrier on $projection.CarrierId = _Carrier.AirlineID
       association [1..*] to /DMO/I_Connection as _Connection on $projection.ConnectionId = _Connection.ConnectionID
{
    key travel_id as TravelId,
    key booking_id as BookingId, 
    booking_date as BookingDate,
    customer_id as CustomerId,
    carrier_id as CarrierId,
    connection_id as ConnectionId,
    flight_date as FlightDate,
    flight_price as FlightPrice,
    currency_code as CurrencyCode,
    booking_status as BookingStatus,
    last_change_at as LastChangeAt,
    _Travel,
    _BoookingSupplement,
    _Customer,
    _Carrier,
    _Connection
}
