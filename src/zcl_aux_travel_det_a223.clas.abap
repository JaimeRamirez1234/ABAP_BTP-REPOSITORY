CLASS zcl_aux_travel_det_a223 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: tt_travel_reported       TYPE TABLE FOR REPORTED Z_I_TRAVEL_LOG_A23,
           tt_booking_reported      TYPE TABLE FOR REPORTED Z_I_BOOKING_LOG_A223,
           tt_supplement_reported   TYPE TABLE FOR REPORTED Z_I_BOOKSUPPL_LOG_A223.

    TYPES: tt_travel_id TYPE TABLE of /dmo/travel_id.


    CLASS-METHODS calculate_price IMPORTING it_travel_id       TYPE tt_travel_id
                                  EXPORTING et_travel_reported TYPE tt_travel_reported.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_aux_travel_det_a223 IMPLEMENTATION.

  METHOD calculate_price.

        DATA: lv_total_booking_price TYPE /dmo/total_price,
              lv_total_suppl_price TYPE /dmo/total_price.

        IF it_travel_id IS INITIAL.
            RETURN.
        ENDIF.

        READ ENTITIES OF Z_I_TRAVEL_LOG_A23
             ENTITY Travel
             FIELDS ( TravelId CurrencyCode )
             WITH VALUE #( for lv_travel_id in it_travel_id (
                               TravelId = lv_travel_id ) )
             RESULT data(lt_read_travel).

       READ ENTITIES OF Z_I_TRAVEL_LOG_A23
             ENTITY Travel BY \_Booking
             FROM VALUE #( for lv_travel_id in it_travel_id (
                               TravelId = lv_travel_id
                               %control-FlightPrice = if_abap_behv=>mk-on
                               %control-CurrencyCode = if_abap_behv=>mk-on ) )
             RESULT data(lt_read_booking).

       LOOP AT lt_read_booking INTO DATA(ls_booking)
            GROUP BY ls_booking-TravelId INTO DATA(lv_travel_key).

            ASSIGN lt_read_travel[ KEY entity components TravelId = lv_travel_key ]
                to FIELD-SYMBOL(<ls_travel>).


            LOOP AT GROUP lv_travel_key INTO DATA(ls_booking_result)
                    GROUP BY ls_booking_result-CurrencyCode INTO DATA(lv_curr).

                lv_total_booking_price = 0.

                LOOP AT GROUP lv_curr INTO DATA(ls_booking_line).
                    lv_total_booking_price += ls_booking_line-FlightPrice.
                ENDLOOP.

                IF lv_curr eq <ls_travel>-CurrencyCode.
                    <ls_travel>-TotalPrice += lv_total_booking_price.
                ELSE.
                    /dmo/cl_flight_amdp=>convert_currency(
                      EXPORTING
                        iv_amount               = lv_total_booking_price
                        iv_currency_code_source = lv_curr
                        iv_currency_code_target = <ls_travel>-CurrencyCode
                        iv_exchange_rate_date   = cl_abap_context_info=>get_system_date(  )
                      IMPORTING
                        ev_amount               = data(lv_amount_converted) ).

                    <ls_travel>-TotalPrice += lv_amount_converted.

                ENDIF.

            ENDLOOP.

       ENDLOOP.


       READ ENTITIES OF Z_I_TRAVEL_LOG_A23
             ENTITY Booking BY \_BoookingSupplement
             FROM VALUE #( for ls_travel in lt_read_booking (
                               TravelId = ls_travel-TravelId
                               BookingId = ls_travel-BookingId
                               %control-Price = if_abap_behv=>mk-on
                               %control-Currency = if_abap_behv=>mk-on ) )
             RESULT data(lt_read_supplements).

       LOOP AT lt_read_supplements INTO DATA(ls_booking_suppl)
            GROUP BY ls_booking_suppl-TravelId INTO lv_travel_key.

                ASSIGN lt_read_travel[ KEY entity components TravelId = lv_travel_key ] to <ls_travel>.

            LOOP AT GROUP lv_travel_key INTO DATA(ls_supplements_result)
                   GROUP BY ls_supplements_result-Currency INTO lv_curr.

                   lv_total_suppl_price = 0.

                   LOOP AT GROUP lv_curr INTO DATA(ls_supplement_line).

                        lv_total_suppl_price += ls_supplement_line-Price.

                   ENDLOOP.

                   IF lv_curr eq <ls_travel>-CurrencyCode.
                        <ls_travel>-TotalPrice += lv_total_suppl_price.
                   ELSE.
                        /dmo/cl_flight_amdp=>convert_currency(
                          EXPORTING
                            iv_amount               = lv_total_suppl_price
                            iv_currency_code_source = lv_curr
                            iv_currency_code_target = <ls_travel>-CurrencyCode
                            iv_exchange_rate_date   = cl_abap_context_info=>get_system_date(  )
                          IMPORTING
                            ev_amount               = lv_amount_converted ).

                        <ls_travel>-TotalPrice += lv_amount_converted.

                   ENDIF.

            ENDLOOP.

       ENDLOOP.

       MODIFY ENTITIES OF z_i_travel_log_a23
              ENTITY Travel
              UPDATE FROM VALUE #( for ls_travel_bo in lt_read_travel (
                                       TravelId = ls_travel_bo-TravelId
                                       TotalPrice = ls_travel_bo-TotalPrice
                                       %control-TotalPrice = if_abap_behv=>mk-on ) ).





  ENDMETHOD.

ENDCLASS.
