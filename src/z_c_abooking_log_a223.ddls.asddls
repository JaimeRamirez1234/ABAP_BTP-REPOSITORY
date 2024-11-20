@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption - Booking Approval'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity Z_C_ABOOKING_LOG_A223 
as projection on Z_I_BOOKING_LOG_A223
{
    key TravelId,
    key BookingId,
        BookingDate,
        CustomerId,
        @ObjectModel.text.element: [ 'CarrierName' ]
        CarrierId,
        _Carrier.Name as CarrierName,
        ConnectionId,
        FlightDate,
        @Semantics.amount.currencyCode: 'CurrencyCode'
        FlightPrice,
        @Semantics.currencyCode: true
        CurrencyCode,
        BookingStatus,
        LastChangeAt,
        /* Associations */
        _Travel : redirected to parent Z_C_ATRAVEL_LOG_A23,
        _Customer,
        _Carrier
}
