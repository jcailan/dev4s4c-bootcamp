CLASS zcl_change_matdesc_f04 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-METHODS create_product.
    CLASS-METHODS update_product.
ENDCLASS.



CLASS zcl_change_matdesc_f04 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    IF 1 = 2.
      zcl_change_matdesc_f04=>create_product(  ).
    ELSE.
      zcl_change_matdesc_f04=>update_product(  ).
    ENDIF.
  ENDMETHOD.

  METHOD create_product.
    DATA product_detail TYPE TABLE FOR CREATE I_ProductTP_2.

    product_detail = VALUE #( (
     %cid = 'product1'
     Product = 'CUSTOM_PRODUCT_F04'
     %control-Product = if_abap_behv=>mk-on
     ProductType = 'FERT'
     %control-ProductType = if_abap_behv=>mk-on
     BaseUnit = 'EA'
     %control-BaseUnit = if_abap_behv=>mk-on
     IndustrySector = 'M'
     %control-IndustrySector = if_abap_behv=>mk-on
     ) ).

    MODIFY ENTITIES OF I_ProductTP_2
     ENTITY Product
     CREATE FROM product_detail
     CREATE BY \_ProductDescription
     FIELDS ( Language ProductDescription ) WITH VALUE #( (
     %cid_ref = 'product1'
     Product = 'CUSTOM_PRODUCT_F04'
     %target = VALUE #(
     (
     %cid = 'desc1'
     Product = 'CUSTOM_PRODUCT_F04'
     Language = 'E'
     ProductDescription = 'Custom product created with ABAP Cloud'
     )
     (
     %cid = 'desc2'
     Product = 'CUSTOM_PRODUCT_F04'
     Language = 'D'
     ProductDescription = 'Custom product created with ABAP Cloud'
     )
     )
     ) )

     MAPPED DATA(mapped)
     REPORTED DATA(reported)
     FAILED DATA(failed).

    COMMIT ENTITIES
     RESPONSE OF I_ProductTP_2
       FAILED DATA(failed_commit)
       REPORTED DATA(reported_commit).
  ENDMETHOD.

  METHOD update_product.
    MODIFY ENTITIES OF I_ProductTP_2
     ENTITY ProductDescription
     UPDATE FIELDS ( ProductDescription )
     WITH VALUE #( (
        Product = 'DUMMY_PRODUCT_F04'
        Language = 'EN'
        ProductDescription = 'Dummy product updated through CDS API'
     ) )

     MAPPED DATA(mapped)
     REPORTED DATA(reported)
     FAILED DATA(failed).

    COMMIT ENTITIES
     RESPONSE OF I_ProductTP_2
       FAILED DATA(failed_commit)
       REPORTED DATA(reported_commit).
  ENDMETHOD.
ENDCLASS.
