CLASS lhc_Supplement DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS calculateTotalSupplPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Supplement~calculateTotalSupplPrice.

ENDCLASS.

CLASS lhc_Supplement IMPLEMENTATION.

  METHOD calculateTotalSupplPrice.

        if NOT keys is INITIAL.
        zcl_aux_travel_det_a223=>calculate_price( it_travel_id =
                                                  VALUE #( for groups <booking_suppl> of booking_key in keys
                                                  GROUP BY booking_key-TravelId WITHOUT MEMBERS ( <booking_suppl> ) ) ).
        ENDIF.


  ENDMETHOD.

ENDCLASS.
