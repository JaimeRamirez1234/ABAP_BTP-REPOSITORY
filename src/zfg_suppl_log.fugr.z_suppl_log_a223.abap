FUNCTION z_suppl_log_a223.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IT_SUPPLEMENTS) TYPE  ZTT_SUPPLE_LOG_A223
*"     REFERENCE(IV_OP_TYPE) TYPE  ZDE_FLAG_A223
*"  EXPORTING
*"     REFERENCE(EV_UPDATED) TYPE  ZDE_FLAG_A223
*"----------------------------------------------------------------------
    CHECK not it_supplements IS INITIAL.

    Case iv_op_type.
        WHEN 'C'.
            INSERT zbooksuppl_loga2 FROM TABLE @it_supplements.
        WHEN 'U'.
            UPDATE zbooksuppl_loga2 FROM TABLE @it_supplements.
        WHEN 'D'.
            DELETE zbooksuppl_loga2 FROM TABLE @it_supplements.
    ENDCASE.

    IF sy-subrc eq 0.
        ev_updated = abap_true.
    ENDIF.

  ENDFUNCTION.
