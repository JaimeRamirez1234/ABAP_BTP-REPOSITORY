CLASS zcl_insert_data_log_a223 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_insert_data_log_a223 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: lt_travel TYPE TABLE OF ztravel_log_a223,
          lt_booking TYPE TABLE OF zbooking_log_a23,
          lt_book_sup TYPE TABLE OF zbooksuppl_loga2.

    SELECT travel_id,
           agency_id,
           customer_id,
           begin_date,
           end_date,
           booking_fee,
           total_price,
           currency_code,
           description,
           status AS overall_status,
           createdby AS created_by,
           createdat AS created_at,
           lastchangedby as last_changed_by,
           lastchangedat as last_change_at
    From /dmo/travel INTO CORRESPONDING FIELDS OF TABLE @lt_travel
    UP TO 50 ROWS.

    SELECT * FROM /dmo/booking
        FOR ALL ENTRIES IN @lt_travel
        where travel_id eq @lt_travel-travel_id
        INTO CORRESPONDING FIELDS OF TABLE @lt_booking.

*    SELECT * FROM /dmo/book_suppl
*       FOR ALL ENTRIES IN @lt_booking
*       WHERE travel_id eq @lt_booking-travel_id
*         AND booking_id eq @lt_booking-booking_id
*       INTO CORRESPONDING FIELDS OF TABLE @lt_book_sup.

     SELECT travel_id,
            booking_id,
            booking_supplement_id,
            supplement_id,
            price,
            currency_code as Currency
            FROM /dmo/book_suppl
            FOR ALL ENTRIES IN @lt_booking
            WHERE travel_id EQ @lt_booking-travel_id
            AND   booking_id EQ @lt_booking-booking_id
            INTO CORRESPONDING FIELDS OF TABLE @lt_book_sup.



   DELETE FROM: ztravel_log_a223,
                zbooking_log_a23,
                zbooksuppl_loga2.
   INSERT: ztravel_log_a223 FROM TABLE @lt_travel,
           zbooking_log_a23 FROM TABLE @lt_booking,
           zbooksuppl_loga2 FROM TABLE @lt_book_sup.

   out->write( 'DONE!' ).


  ENDMETHOD.

ENDCLASS.
