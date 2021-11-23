*&---------------------------------------------------------------------*
*& Report zaxyt_bv_001
*&---------------------------------------------------------------------*
*& Value 操作符详解
*&---------------------------------------------------------------------*
REPORT zaxyt_bv_001.

*  定义数据结构
TYPES:
  BEGIN OF ty_001,
    code  TYPE char2,
    value TYPE char10,
  END OF ty_001.
TYPES:tty_001 TYPE TABLE OF ty_001 WITH DEFAULT KEY.
DATA: itab1 TYPE TABLE OF ty_001.

* 声明结构类型之后赋值
DATA wa TYPE ty_001.
wa = VALUE #( code = '01' value = 'test1' ).

* 直接声明赋值
DATA(wa1) = VALUE ty_001( code = '02' value = 'test2' ).

* BASE关键字
DATA(wa2) = VALUE #( BASE wa1 code = '03' ).

*内表赋值 - 使用表类型
DATA(itab) = VALUE tty_001( ( code = '04' value = 'test04' )
                            ( code = '05' value = 'test05' ) ).

*内表赋值 - 不使用表类型,测试 Append
itab1 = VALUE #( ( code = '06' value = 'test06' )
                ( code = '07' value = 'test07' ) ).
APPEND VALUE #( code = '08' value = 'test08' ) TO itab1.

* 另外一种添加方式
itab1 = VALUE #( BASE itab1 ( code = '09' value = 'test01' )
                            ( code = '10' value = 'test10' ) ).
* 读取内表的值
DATA(wa3) = itab1[ code = '09' ].

* 读取不存在的值 - Catch
*TRY.
*    DATA(wa4) = itab1[ code = '11' ].
*  CATCH cx_sy_itab_line_not_found INTO DATA(exc).
*
*ENDTRY.

* 读取不存在的值 - optional
*data(wa4) = value #( itab1[ code = '11' ] OPTIONAL ).

* 读取值,不存在的话给一个默认值
data(wa5) = value ty_001( code = '00' value = 'test00' ).
data(wa4) = value #( itab1[ code = '11' ] DEFAULT wa5 ).

* 输出
cl_demo_output=>new( )->next_section( |声明结构类型之后赋值| )->write( wa
                      )->next_section( |直接声明赋值| )->write( wa1
                      )->next_section( |BASE关键字| )->write( wa2
                      )->next_section( |内表赋值| )->write( itab
                      )->next_section( |内表赋值| )->write( itab1
                      )->next_section( |内表赋值| )->write( wa3
                      )->next_section( |内表赋值| )->write( wa4
                      )->display( ).
