@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption - Travel'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity Z_C_TRAVEL_LOG_A23
  as projection on Z_I_TRAVEL_LOG_A23
{
  key     TravelId,
          @ObjectModel.text.element: [ 'AgencyName' ]
          AgencyId,
          _Agency.Name       as AgencyName,
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
          OverallStatus,
          LastChangeAt,
          @Semantics.amount.currencyCode: 'CurrencyCode'
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_VIRT_ELEM_A223'
  virtual DiscountPrice : /dmo/total_price,
          /* Associations */
          _Agency,
          _Booking : redirected to composition child Z_C_BOOKING_LOG_A223,
          _Currency,
          _Customer


}
