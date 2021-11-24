*&---------------------------------------------------------------------*
*& Report zaxyt_bv_002
*&---------------------------------------------------------------------*
*& Filter 操作符详解
*&---------------------------------------------------------------------*
REPORT zaxyt_bv_002.

* 定义数据类型
TYPES:BEGIN OF ty_001,
        code  TYPE char2,
        value TYPE char10,
      END OF ty_001.
DATA itab TYPE SORTED TABLE OF ty_001 WITH NON-UNIQUE KEY code.
DATA itabs TYPE STANDARD TABLE OF ty_001
      WITH NON-UNIQUE SORTED KEY cod COMPONENTS code.
DATA it_cond TYPE SORTED TABLE OF char2  WITH NON-UNIQUE KEY table_line.

*初始化内表
itab = VALUE #( ( code = '01' value = 'test01' )
                ( code = '01' value = 'test001' )
                ( code = '02' value = 'test02' )
                ( code = '03' value = 'test003' )
                ( code = '02' value = 'test021' )
                ( code = '03' value = 'test031' ) ).
* 标准表赋值
itabs = VALUE #( ( code = '01' value = 'test01' )
                ( code = '01' value = 'test001' )
                ( code = '02' value = 'test02' )
                ( code = '03' value = 'test003' )
                ( code = '02' value = 'test021' )
                ( code = '03' value = 'test031' ) ).
* 直接Filter
DATA(it_filter) = FILTER #( itab WHERE code = '01' ).

* 使用 except 语句
DATA(it_exp) = FILTER #( itab EXCEPT WHERE code = '01' ).

* 标准表 filter
DATA(it_filters) = FILTER #( itabs USING KEY cod WHERE code = '01' ).

* 使用多个值筛选
it_cond = VALUE #( ( '01' ) ( '03' ) ).
DATA(it_fcond) = FILTER #( itab IN it_cond WHERE code = table_line ).

* 显示数据
cl_demo_output=>new(
    )->next_section( |初始化内表| )->write( itab
    )->next_section( |直接Filter| )->write( it_filter
    )->next_section( |使用 except 语句| )->write( it_exp
    )->next_section( |标准表赋值| )->write( itabs
    )->next_section( |标准表 filter| )->write( it_filters
    )->next_section( |使用多个值筛选| )->write( it_fcond
    )->display( ).
