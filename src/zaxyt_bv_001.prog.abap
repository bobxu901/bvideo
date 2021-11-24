*&---------------------------------------------------------------------*
*& Report zaxyt_bv_001
*&---------------------------------------------------------------------*
*& Value 操作符详解
*&---------------------------------------------------------------------*
REPORT zaxyt_bv_001.

* 定义数据结构
TYPES:
  BEGIN OF ty_001,
    code  TYPE char2,
    value TYPE char10,
  END OF ty_001.
TYPES tty_001 TYPE TABLE OF ty_001 WITH DEFAULT KEY.
DATA: itab1 TYPE TABLE OF ty_001.

* 直接定义结构赋值
DATA wa TYPE ty_001.
wa = VALUE #( code = '01' value = 'test01' ).

* 行内声明赋值
DATA(wa1) = VALUE ty_001( code = '02' value = 'test02' ).

* BASE关键字
DATA(wa2) = VALUE #( BASE wa1 code = '03' ).

* 内表赋值
DATA(itab) = VALUE tty_001( ( code = '04' value = 'test04' )
                            ( code = '05' value = 'test05' )  ).
* 声明内表,然后添加记录
itab1 = VALUE #( ( code = '06' value = 'test06' ) ( code = '07' value = 'test07' ) ).
APPEND VALUE #( code = '08' value = 'test08' ) TO itab1.

* BASE 内表操作
itab1 = VALUE #( BASE itab1 ( code = '09' value = 'test09' )
                            ( code = '10' value = 'test10' ) ).

* 读取内表
*data(wa3) = itab1[ code = '11' ].
data(wa_def) = VALUE ty_001( code = '00' value = 'test00' ).
data(wa3) = VALUE #( itab1[ code = '11' ] DEFAULT wa_def ).

cl_demo_output=>new(
      )->next_section( |直接定义结构赋值| )->write( wa
      )->next_section( |行内声明赋值| )->write( wa1
      )->next_section( |BASE关键字| )->write( wa2
      )->next_section( |内表赋值| )->write( itab
      )->next_section( |声明内表,然后添加记录| )->write( itab1
      )->next_section( |读取内表| )->write( wa3
      )->display( ).
