\ 必備的視窗物件
        : 顯示錯誤訊息 ( 訊息置放位置 長度 --- ) ErrorBox ;

        : 顯示訊息 ( 標題字串置放位置 長度 訊息置放位置 長度 --- )

                temp$ place
                temp$ +NULL
                MB_TASKMODAL rot rot
                2dup + 0 swap c! drop  ( rel>abs )
                temp$ 1+ ( rel>abs )
                NULL Call MessageBox drop
                ;
                
                0 value 檔案選單視窗_ID
                FileOpenDialog 檔案選單文字 "檔案選單" "All Files|*.*|"
                FileOpenDialog 來源檔案選單文字 "來源檔案選單" "All Files|*.*|"
                FileSaveDialog 目標檔案選單文字 "目標檔案選單" "All Files|*.*|"
        :Object 檔案選單視窗  <super window
                :M Classinit:   ( -- )
                        ClassInit: super
                        self to 檔案選單視窗_ID
                        ;M
                ;Object

\ 操縱檔案的詞群

        : 開檔 ( 檔名存放位置 檔名長度 檔案屬性  --- 檔頭序號 ) \ 2000/08/30
                rot rot drop 1 - swap
                2dup
                swap count rot
                open-file 0 <> 
                if 
                    drop
                    swap count rot
                    create-file 0 <>
                    if
                           s"  開檔失敗!" 顯示錯誤訊息
                    then
                else
                    rot rot 2drop
                then
                ;
        : 開舊檔 ( 檔名存放位置 檔名長度 檔案屬性 --- 檔頭序號 ) \ 2000/08/30
                open-file 0 <>
                if 
                    s"  開舊檔失敗!" 顯示錯誤訊息
                then
                ;
        : 關檔 ( 檔頭序號  --- )   \ 2000/08/30
                close-file 0 <>
                if
                    s" 關檔失敗!" 顯示錯誤訊息
                then
                ;                
        : 檔案大小? ( 檔頭序號 --- 低32爻 高32爻 ) \ 2000/08/30
                file-size 0 <>
                if
                     s" 檔案操作有誤!" 顯示錯誤訊息 bye
                then
                ;
        : 讀檔 ( 存放位置 長度 檔頭序號  --- 此次讀入的長度 )  \ 2000/08/30
                read-file  0 <>
                if
                    s" 讀檔失敗!" 顯示錯誤訊息 bye
                then
                ;
        : 寫檔 ( 起始位置 長度 檔頭序號  --- )   \ 2000/08/30
                write-file  0 <>
                if
                    s" 寫檔失敗!" 顯示錯誤訊息  bye
                then
                ;
        : 移動檔案指標 ( 低32爻位移值 高32爻位移值 檔頭序號 --- ) \ 2000/08/30
                reposition-file 0 <>
                if
                    s" 移動失敗!" 顯示錯誤訊息 bye
                then
                ;

        : 檔案選單  ( --- 檔名存放位置 檔名長度 ) \ 2000/08/30
                    GetHandle: 檔案選單視窗_ID
                    Start: 檔案選單文字 dup c@
                    if   count
                    ( 2dup cr  ." You are choosed " type cr )
                    else drop s" 檔案選擇錯誤" 顯示錯誤訊息 bye
                    then
                    Close: 檔案選單視窗
                    ;
        : 來源檔案選單  ( --- 檔名存放位置 檔名長度 ) \ 2000/08/30
                    GetHandle: 檔案選單視窗_ID
                    Start: 來源檔案選單文字 dup c@
                    if   count
                    ( 2dup cr  ." You are choosed " type cr )
                    else drop s" 來源檔案選擇錯誤" 顯示錯誤訊息 bye
                    then
                    Close: 檔案選單視窗
                    ;

        : 目標檔案選單  ( --- 檔名存放位置 檔名長度 ) \ 2000/08/30
                    GetHandle: 檔案選單視窗_ID
                    Start: 目標檔案選單文字 dup c@
                    if   count
                    ( 2dup cr  ." You are choosed " type cr )
                    else drop s" 目標檔案選擇錯誤" 顯示錯誤訊息 bye
                    then
                    Close: 檔案選單視窗
                    ;

        : 取新延伸檔名 ( 檔名起始位置 檔名長度 延伸檔名起始位置 延伸檔名長度 新檔名位置 --- )
                dup
                5 roll
                5 roll
                2dup
                ascii . scan  swap drop - 1 +
                2 roll place
                +place
                ;  

 
      
      
      
      
 
                               