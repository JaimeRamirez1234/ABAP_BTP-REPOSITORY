CLASS lhc_Supplement DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS calculateTotalSupplPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Supplement~calculateTotalSupplPrice.

ENDCLASS.

CLASS lhc_Supplement IMPLEMENTATION.

  METHOD calculateTotalSupplPrice.

*        if NOT keys is INITIAL.
*        zcl_aux_travel_det_a223=>calculate_price( it_travel_id =
*                                                  VALUE #( for groups <booking_suppl> of booking_key in keys
*                                                  GROUP BY booking_key-TravelId WITHOUT MEMBERS ( <booking_suppl> ) ) ).
*        ENDIF.

IF NOT keys IS INITIAL.
        zcl_aux_travel_det_a223=>calculate_price( it_travel_id =
                                                 VALUE #( FOR GROUPS <booking_suppl> OF booking_key IN keys
                                                 GROUP BY booking_key-TravelId WITHOUT MEMBERS ( <booking_suppl> ) ) ).
ENDIF.


  ENDMETHOD.

ENDCLASS.

CLASS lsc_supplement DEFINITION INHERITING FROM cl_abap_behavior_saver.

PUBLIC SECTION.

    CONSTANTS: create type string value 'C',
               update type string value 'U',
               delete type string value 'D'.


PROTECTED SECTION.
    METHODS save_modified REDEFINITION.


ENDCLASS.

CLASS lsc_supplement IMPLEMENTATION.

  METHOD save_modified.
        DATA: lt_supplements TYPE STANDARD TABLE OF zbooksuppl_loga2,
              lv_op_type TYPE zde_flag_a223,
              lv_updated TYPE zde_flag_a223.

        IF NOT CREATE-supplement is INITIAL.
            lt_supplements = CORRESPONDING #( CREATE-supplement ).
            lv_op_type = lsc_supplement=>create.
        ENDIF.

        IF NOT update-supplement is INITIAL.
            lt_supplements = CORRESPONDING #( update-supplement ).
            lv_op_type = lsc_supplement=>update.
        ENDIF.

        IF NOT delete-supplement is INITIAL.
            lt_supplements = CORRESPONDING #( delete-supplement ).
            lv_op_type = lsc_supplement=>delete.
        ENDIF.

        if not lt_supplements is INITIAL.
            CALL FUNCTION 'Z_SUPPL_LOG_A223'
              EXPORTING
                it_supplements = lt_supplements
                iv_op_type     = lv_op_type
              IMPORTING
                ev_updated     = lv_updated .

              IF lv_updated EQ abap_true.
                    "REPORTED-supplement
              ENDIF.

        ENDIF.

  ENDMETHOD.

ENDCLASS.
