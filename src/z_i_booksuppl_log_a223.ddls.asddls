@AbapCatalog.sqlViewName: 'ZV_BOOK_LOG_A223'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface - Booking Supplement'
@Metadata.ignorePropagatedAnnotations: true
define view Z_I_BOOKSUPPL_LOG_A223
  as select from zbooksuppl_loga2 as BookingSupplement
        association to parent Z_I_BOOKING_LOG_A223 as _Booking on $projection.TravelId = _Booking.TravelId
                                                              and $projection.BookingId = _Booking.BookingId
        association [1..1] to Z_I_TRAVEL_LOG_A23 as _Travel on $projection.TravelId = _Travel.TravelId
        association [1..1] to /DMO/I_Supplement as _Product on $projection.SupplementId = _Product.SupplementID
        association [1..*] to /DMO/I_SupplementText as _SupplementText on $projection.SupplementId = _SupplementText.SupplementID 
{
    key travel_id as TravelId,
    key booking_id as BookingId,
    key booking_supplement_id as BookingSupplementId,
        supplement_id as SupplementId,
        @Semantics.amount.currencyCode: 'Currency'
        price as Price,
        @Semantics.currencyCode: true
        currency as Currency,
        @Semantics.systemDateTime.lastChangedAt: true
        _Travel.LastChangeAt,
        _Booking,
        _Travel,
        _Product,
        _SupplementText
}
