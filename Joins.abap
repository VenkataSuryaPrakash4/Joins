*&---------------------------------------------------------------------*
*& Report ZRCLASSIC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrclassic NO STANDARD PAGE HEADING LINE-SIZE 140 LINE-COUNT 60(3).
TABLES:kna1.
SELECT-OPTIONS:s_kunnr FOR kna1-kunnr.
PARAMETERS:p_file type string.

AT SELECTION-SCREEN ON S_KUNNR.
TOP-OF-PAGE.
  WRITE:'Classical Report'.

end-of-PAGE.
  WRITE:'End of report'.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
START-OF-SELECTION.
*---Inner Join
  SELECT a~prefix,a~customer_number,
  a~customer_name,a~aadhar_number,
  b~cutomer_number,
  b~room_type, b~room_number,
  b~number_of_days, b~total_price
  FROM ztcust_details AS a
  INNER JOIN ztbooking AS b
  ON a~customer_number = b~cutomer_number
  INTO TABLE @DATA(lt_inner)
  WHERE a~customer_number IN @s_kunnr.

*---- Left Outer Join
  SELECT a~prefix,a~customer_number,
  a~customer_name,a~aadhar_number,
  b~cutomer_number,
  b~room_type, b~room_number,
  b~number_of_days, b~total_price
  FROM ztcust_details AS a
  LEFT OUTER JOIN ztbooking AS b
  ON a~customer_number = b~cutomer_number
  INTO TABLE @DATA(lt_left)
  WHERE a~customer_number IN @s_kunnr.

*---- Right Outer join
  SELECT a~prefix,a~customer_number,
  a~customer_name,a~aadhar_number,
  b~cutomer_number,
  b~room_type, b~room_number,
  b~number_of_days, b~total_price
  FROM ztcust_details AS a
  RIGHT OUTER JOIN ztbooking AS b
  ON a~customer_number = b~cutomer_number
  INTO TABLE @DATA(lt_right)
  WHERE a~customer_number IN @s_kunnr.

*---Cross Join
  SELECT a~prefix,a~customer_number,
  a~customer_name,a~aadhar_number,
  b~cutomer_number,
  b~room_type, b~room_number,
  b~number_of_days, b~total_price
  FROM ztcust_details AS a
  CROSS JOIN ztbooking AS b
  INTO TABLE @DATA(lt_cross)
  WHERE a~customer_number IN @s_kunnr.

*---Multiple join
  SELECT a~prefix,a~customer_number,
  a~customer_name,a~aadhar_number,
  b~cutomer_number,
  b~room_type, b~room_number,
  b~number_of_days, b~total_price,
  b~alloted_by,
  c~employee_id,c~employee_name
  FROM ztcust_details AS a
  INNER JOIN ztbooking AS b
  ON a~customer_number = b~cutomer_number
  RIGHT OUTER JOIN ztemployee AS c
  ON b~alloted_by = c~employee_id
  INTO TABLE @DATA(lt_multi)
  WHERE a~customer_number IN @s_kunnr.


  WRITE: 'Inner Join'.
  ULINE.
  SORT lt_inner BY customer_number.
  LOOP AT lt_inner INTO DATA(lwa_join).
    WRITE:/ lwa_join-customer_number,lwa_join-prefix,
            lwa_join-customer_name,lwa_join-aadhar_number,
            lwa_join-room_type,lwa_join-room_number,
            lwa_join-number_of_days,lwa_join-total_price.
    CLEAR:lwa_join.
  ENDLOOP.

  SKIP 2.
  WRITE: 'Left'.
  ULINE.
  SORT lt_left BY customer_number.
  LOOP AT lt_left INTO lwa_join.
    WRITE:/ lwa_join-customer_number,lwa_join-prefix,
            lwa_join-customer_name,lwa_join-aadhar_number,
            lwa_join-room_type,lwa_join-room_number,
            lwa_join-number_of_days,lwa_join-total_price.
    CLEAR:lwa_join.
  ENDLOOP.

  SKIP 2.
  WRITE: 'Right'.
  ULINE.
  SORT lt_right BY customer_number.
  LOOP AT lt_right INTO lwa_join.
    WRITE:/ lwa_join-customer_number,lwa_join-prefix,
            lwa_join-customer_name,lwa_join-aadhar_number,
            lwa_join-room_type,lwa_join-room_number,
            lwa_join-number_of_days,lwa_join-total_price.
    CLEAR:lwa_join.
  ENDLOOP.

  SKIP 2.
  WRITE: 'Cross'.
  ULINE.
  SORT lt_cross BY customer_number.
  LOOP AT lt_cross INTO lwa_join.
    WRITE:/ lwa_join-customer_number,lwa_join-prefix,
            lwa_join-customer_name,lwa_join-aadhar_number,
            lwa_join-room_type,lwa_join-room_number,
            lwa_join-number_of_days,lwa_join-total_price.
    CLEAR:lwa_join.
  ENDLOOP.

  SKIP 2.
  WRITE: 'Multi'.
  ULINE.
  SORT lt_multi BY customer_number.
  LOOP AT lt_multi INTO DATA(lwa_multi).
    WRITE:/ lwa_multi-customer_number,lwa_multi-prefix,
            lwa_multi-customer_name,lwa_multi-aadhar_number,
            lwa_multi-room_type,lwa_multi-room_number,
            lwa_multi-number_of_days,lwa_multi-total_price,
            lwa_multi-employee_id,lwa_multi-employee_name.
    CLEAR:lwa_multi.
  ENDLOOP.
