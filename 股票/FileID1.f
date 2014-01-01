fload FileIO.f

\ fid1
 0 constant    檔頭序號
 4 constant    檔案屬性
 8 constant    檔案長度
16 constant    檔案欲讀長度
20 constant    檔案讀取長度
24 constant    檔名          \ [檔名長度]+[檔名字串]
\ fid1+[檔名]  檔案資料 

:  檔案資料 ( fid -- 檔案資料位移 ) 
   檔名 + dup @ 4 +  
   ;

 0 value fid1
 
\ 初始 file1_buffer 設為 4096byte 
4096 allocate drop to fid1
4000 fid1 檔案欲讀長度 + !
r/w fid1 檔案屬性 + !   
\ create fid1_buf 4096 allot
\ fid_buf to fid1

        
: 開檔1 ( -- )
  fid1 檔名 + lcount
  fid1 檔案屬性 + @
  開舊檔
  fid1 檔頭序號 + ! 
  ;
  
: 關檔1 ( -- )
  fid1 @ 關檔
  fid1 free
  ;
  
  
: 讀檔1 ( -- )
  \ 變更 buffer
  fid1 檔名 + dup @ 4 + + 
  fid1 檔案欲讀長度 + @
  fid1 檔頭序號 + @    
  讀檔 
  fid1 檔案讀取長度 + !  
  ; 
 

: 寫檔1 ( 起始位置 長度 -- )  
  fid1 檔頭序號 + @
  寫檔
  ;