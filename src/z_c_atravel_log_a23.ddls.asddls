@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption - Atravel'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity Z_C_ATRAVEL_LOG_A23
  as projection on Z_I_TRAVEL_LOG_A23
{
  key TravelId,
      @ObjectModel.text.element: [ 'AgencyName' ]
      AgencyId,
      _Agency.Name as AgencyName,
      @ObjectModel.text.element: [ 'CustomerName' ]
      CustomerId,
      _Customer.LastName as CustomerName,
      BeginDate,
      EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,
      @Semantics.currencyCode: true
      CurrencyCode,
      Description,
      OverallStatus as TravelStatus,
      LastChangeAt,
      /* Associations */
      _Booking : redirected to composition child Z_C_ABOOKING_LOG_A223,
      _Agency,
      _Customer
}
