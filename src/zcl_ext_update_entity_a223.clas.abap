CLASS zcl_ext_update_entity_a223 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
        INTERFACES if_oo_adt_classrun.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ext_update_entity_a223 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

         MODIFY ENTITIES OF z_i_travel_log_a23
                ENTITY Travel
                UPDATE FIELDS (  AgencyId Description )
                WITH VALUE #( ( TravelId = '00000015'
                                AgencyId = '070024'
                                Description = 'New external Update' ) )
                FAILED DATA(failed)
                REPORTED DATA(reported).


         READ ENTITIES OF z_i_travel_log_a23
                ENTITY Travel
                FIELDS ( AgencyId Description )
                WITH VALUE #( ( TravelId = '00000015' ) )
                RESULT DATA(lt_travel_data)
                FAILED failed
                REPORTED reported.

         COMMIT ENTITIES.

         IF failed IS INITIAL.
            out->write( 'Commit Successfull' ).
         ELSE.
            out->write( 'Commit Failed' ).
         ENDIF.

  ENDMETHOD.

ENDCLASS.
