CLASS zcl_material_information_f04 DEFINITION
PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS get_material_art
      IMPORTING
        matnr               TYPE i_product-product
      RETURNING
        VALUE(material_art) TYPE i_product-producttype.
ENDCLASS.


CLASS zcl_material_information_f04 IMPLEMENTATION.

  METHOD get_material_art.
*    DATA material TYPE mara.
*    DATA production_date TYPE datn.
*    DATA bool_tmp TYPE boole_d.
*    production_date = sy-datum.
*    SELECT SINGLE mtart
*    FROM mara
*    INTO CORRESPONDING FIELDS OF material
*    WHERE matnr = matnr.
*    MOVE material-mtart TO material_art.

    DATA material TYPE i_product.
    DATA production_date TYPE datn.
    DATA bool_tmp TYPE abap_boolean.
    production_date = cl_abap_context_info=>get_system_date( ).

    " Use of released API
    SELECT SINGLE FROM i_product
    FIELDS producttype
    WHERE product = @matnr
    INTO CORRESPONDING FIELDS OF @material .

    material_art = material-producttype.
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    DATA material_info TYPE REF TO zcl_material_information_f04.
    material_info = NEW zcl_material_information_f04( ).
    DATA(material_art) = material_info->get_material_art( '000000000299900003' ).
    out->write( material_art ).
  ENDMETHOD.

ENDCLASS.
