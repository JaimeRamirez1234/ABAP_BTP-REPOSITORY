@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption - Booking Supplement'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity Z_C_BOOKSUPPL_LOG_A223
  as projection on Z_I_BOOKSUPPL_LOG_A223
{
  key TravelId,
  key BookingId,
  key BookingSupplementId,
      @ObjectModel.text.element: ['SupplementDesccription']
      SupplementId,
      _SupplementText.Description as SupplementDesccription : localized,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      @Semantics.currencyCode: true
      Currency as CurrencyCode,
      LastChangeAt,
      /* Associations */
      _Travel : redirected to Z_C_TRAVEL_LOG_A23,
      _Booking : redirected to parent Z_C_BOOKING_LOG_A223,
      _Product,
      _SupplementText
}
