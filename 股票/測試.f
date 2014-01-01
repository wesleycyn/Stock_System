: demo_test1 ( -- )  
     1   50   220   50  200   畫k線
     2  150   300  100  200   畫k線
     3  200   300  100  150   畫k線 
     4  150   300  100  150   畫k線
     5  250   300  100  200   畫k線           
     6  200   300   50  200   畫k線
     7  100   100  100  100   畫k線             
     8  300   300  100  300   畫k線  
     9  100   100  300  100   畫k線
     10 150   200  100  150   畫k線  
     ;  
0 value ior1
0 value eof1     
0 value readflg 

     
: demo_test    
\  readflg 0 = if  
  1 to 項序
  s" 4743_20130506.txt" fid1 檔名 + lplace
  開檔1
  
  temp$ 1 + 1024 fid1 檔頭序號 + @  read-line  to ior1  to eof1 drop

  \ 300 0 do
   begin
    temp$ 1 +  1024 fid1 檔頭序號 + @  read-line  to ior1  to eof1 temp$ c!  
  
    eof1   while
  
  分割  
  項序
  開盤價$ 轉值    
  最高價$ 轉值   
  最低價$ 轉值    
  收盤價$ 轉值    
  
  畫k線
  
\  收盤價 mcad1 5 mcad to mcad1
  
    項序 1 + to 項序


    repeat
 \ loop
  關檔1  
\  then
  
\   1 to readflg
  ;     