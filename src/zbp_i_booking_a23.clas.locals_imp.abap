CLASS lhc_Booking DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS calculateTotalFlightPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Booking~calculateTotalFlightPrice.

    METHODS validateStatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR Booking~validateStatus.

    METHODS: get_instance_features       FOR INSTANCE FEATURES IMPORTING keys REQUEST requested_features FOR Booking RESULT result.

ENDCLASS.

CLASS lhc_Booking IMPLEMENTATION.

  METHOD calculateTotalFlightPrice.

     if NOT keys is INITIAL.
        zcl_aux_travel_det_a223=>calculate_price( it_travel_id =
                                                  VALUE #( for groups <booking> of booking_key in keys
                                                  GROUP BY booking_key-TravelId WITHOUT MEMBERS ( <booking> ) ) ).
     ENDIF.

  ENDMETHOD.

  METHOD validateStatus.

    READ ENTITY z_i_booking_log_a223
         fields ( BookingStatus )
         WITH VALUE #( FOR <row_key> IN keys ( %key = <row_key>-%key ) )
         result DATA(lt_booking_result).

         LOOP AT lt_booking_result INTO DATA(ls_booking_result).

            CASE ls_booking_result-BookingStatus.
                WHEN 'N'.

                WHEN 'X'.

                WHEN 'B'.

                WHEN OTHERS.
                    APPEND VALUE #( %key = ls_booking_result-%key ) TO failed-booking.

                    APPEND VALUE #( %key = ls_booking_result-%key
                                    %msg = new_message( id = 'Z_MC_TRAVEL_LOG_A223'
                                                          number = '007'
                                                          v1 = ls_booking_result-BookingStatus
                                                          severity = if_abap_behv_message=>severity-error )
                                    %element-BookingStatus = if_abap_behv=>mk-on ) TO reported-booking.

            ENDCASE.

         ENDLOOP.

  ENDMETHOD.

  METHOD get_instance_features.
        READ ENTITIES OF z_i_travel_log_a23
             ENTITY Booking
             FIELDS ( BookingId BookingDate CustomerId BookingStatus )
                    WITH VALUE #( for keyval in keys ( %key = keyval-%key ) )
             RESULT DATA(lt_booking_result).

        RESULT = VALUE #( FOR LS_TRAVEL IN lt_booking_result
                          ( %key   = ls_travel-%key
                            %assoc-_BoookingSupplement = if_abap_behv=>fc-o-enabled  ) ).

  ENDMETHOD.

ENDCLASS.
