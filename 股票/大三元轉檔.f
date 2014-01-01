fload FileID1.f
0 value 丁
0 value 兜 
0 value 秨絃基
0 value 程蔼基
0 value 程基
0 value Μ絃基
0 value Θユ秖

0 value new_len
0 value new_adr
0 value save_len
0 value save_adr

create cyn  1024 allot

create 秨絃基$ 256 allot
create 程蔼基$ 256 allot
create 程基$ 256 allot
create Μ絃基$ 256 allot
create Θユ秖$ 256 allot
create 丁$   256 allot



: 锣 { adr | num dot flg -- number }
  0 to num
  0 to dot
  0 to flg  
   adr c@ 0 do
   
   flg 0 =
   if
    num 10 * to num
    adr i + 1 + c@  \ dup emit cr 
    dup 0x2e =
      if
        drop
        1 to flg
        num 10 * to num
      else
        0x30 -
        num + 
        to num
      then
    else
      flg 1 + to flg
      dot 10 * to dot
      adr i + 1 + c@  \ dup emit cr
        0x30 -
        dot + 
        to dot             
    then     
  loop    
    flg case
    0 of  num 100 * dot +  endof
    1 of  num dot +  endof
    2 of  num dot 10 * +  endof
    3 of  num dot +  endof
    endcase
    
    ;  
  

: だ澄 { adr | -- }
  save_adr 1 +  save_len 0x09 scan  to new_len to new_adr
  save_adr 1 +  save_len new_len -  adr place
  new_len to save_len
  new_adr to save_adr
  ;

: だ澄 ( -- )
  temp$ count 0x09 scan  to new_len to new_adr
  temp$ count new_len - 丁$ place
  new_len to save_len
  new_adr to save_adr  
\  ." 丁" 丁$ count type 
    
  秨絃基$ だ澄
\  ." 秨絃基" 秨絃基$ count type  

  程蔼基$ だ澄
\  ." 程蔼基" 程蔼基$ count type
  
  程基$ だ澄
\  ." 程基" 程基$ count type
    

  Μ絃基$ だ澄
\  ." Μ絃基" Μ絃基$ count type
  
  Θユ秖$ だ澄
\  ." Θユ秖" Θユ秖$ count type   \ Θユ秖$ number drop
  ; 


\s 

: test { | eof ior -- }
  s" 4743_20130503.txt" fid1 郎 + lplace
  秨郎1
  cr
  \ 100 0 do
  begin
    temp$ 1 +
    1024
      fid1 郎繷腹 + @ 
      read-line  to ior  to eof
      temp$ c!

  cr だ澄           
  ." 丁"   丁$ count type     
  ." 秨絃基" 秨絃基$ count type     
  ." 程蔼基" 程蔼基$ count type    
  ." 程基" 程基$ count type
  ." Μ絃基" Μ絃基$ count type    
  ." Θユ秖" Θユ秖$ count type   \ Θユ秖$ number drop  
   cr
     
    eof 0 = until
  ;
  
 

  