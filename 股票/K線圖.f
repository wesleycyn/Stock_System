anew 滑鼠視窗

fload 大三元轉檔.f 


	1600 value	WindowSize_W
	800	value	WindowSize_H
	0 value	WindowPosition_X
	0	value	WindowPosition_Y

	variable TimeRate
	  
\ 100 value 最低價
\ 200 value 最高價
\ 150 value 收盤價
\ 130 value 開盤價
\ 6 value   項序 
6 value   間距
10 value   價間隔
800 value 價偏移
  

	1000 TimeRate !				\ init timer to a 2 ms rate		
	ColorObject TheNextColor	\ 使用 顏色物件

:Object 滑鼠     <Super Window	\ 宣告 滑鼠
	: 顏色變更 ( R G B --- )
        rgb NewColor: TheNextColor
        TheNextColor ?ColorCheck
		LineColor: dc
        ;
        
	: 畫點  ( x y --- )
		TheNextColor SetPixel: dc
        ;

: 畫陽線 
        0xff 0 0 顏色變更  
        項序 間距 * 
        價偏移 最高價 價間隔 / -
        Moveto: dc
        項序 間距 * 
        價偏移 最低價 價間隔 / - 
        Lineto: dc
        ;
        
: 畫陰線
        0x0 0x0 0x0 顏色變更
        項序 間距 * 
        價偏移 最高價 價間隔 / -
        Moveto: dc
        項序 間距 * 
        價偏移 最低價 價間隔 / -
        Lineto: dc        
        ;
        
: 畫陽實體             
        項序 間距 * 間距 2 / -  1 +  
        價偏移 開盤價 價間隔 /  -
        項序 間距 * 間距 2 / +  1 -
        價偏移 收盤價 價間隔 /  -
        LTRED FillArea: dc        
        ;     
        
: 畫陰實體        
        項序 間距 * 間距 2 / - 1 +
        價偏移 收盤價 價間隔 /  -
        項序 間距 * 間距 2 / +  1 -
        價偏移 開盤價 價間隔 / - 
        BLACK FillArea: dc  
        ;


: 畫橫線
     \   0xff 0 0 顏色變更  
        項序 間距 * 間距 2 / -  1 + 
        價偏移 收盤價 價間隔 / -
        Moveto: dc
        項序 間距 * 間距 2 / +  1 -
        價偏移 收盤價 價間隔 / - 
        Lineto: dc
        ;


: 畫k線 ( 項序 開盤價 最高價 最低價 收盤價 -- )
  to 收盤價    
  to 最低價
  to 最高價  
  to 開盤價    
  to 項序
        

    收盤價 開盤價  > 
    if
      畫陽線    
      畫陽實體             
    else
      收盤價 開盤價 =
      if        
           最高價 收盤價 - 收盤價 最低價 -  >
        if
          畫陰線            
        else   
          畫陽線                
        then        
        畫橫線
      else
        畫陰線        
        畫陰實體
      then             
    then
    ;
  
  

  
fload 測試.f  
  
  
  
  
	int counter
        
	:M StartSize:   ( -- w h )      \ 此物件的大小
		WindowSize_W WindowSize_H
        ;M
	:M StartPos:    ( -- x y )      \ 物件在 桌面的位置
		WindowPosition_X WindowPosition_Y
        ;M
	:M WindowTitle: ( -- Zstring )  \ 此物件的標題
        z" 滑鼠"
        ;M
	:M On_Paint:    { \ temp$ -- }  \ all window refreshing is done by On_Paint:

     \ 80 250 300 100 200 
     
        0xff 0 0  顏色變更     100 100     Moveto: dc   200 200     Lineto: dc
        0x00 0x00 0xff  顏色變更     100 200     Moveto: dc   200 100     Lineto: dc   
        demo_test                             
		;M
    
	:M On_Init:     ( -- )          \ things to do at the start of window creation
       	On_Init: super             \ do anything superclass needs
        0 to counter               \ then initialize counter is zero
        0 TimeRate @ 1 hWnd Call SetTimer drop        	
       
        
       	;M
       
       :M WM_LBUTTONDOWN ( h m w l -- res )
       		Paint: self

            0
            ;M
                
	:M WM_TIMER     ( h m w l -- res ) \ handle the WM_TIMER events
		1 +to counter              \ bump the counter
    

 
                
        Paint: self                \ refresh the window
        0 ;M
            
	:M On_Done:     ( -- )          \ things to do before program termination
                1 hWnd Call KillTimer drop \ destroy the timer, we are done
                On_Done: super             \ then do things superclass needs
                ;M
                                                
;Object
\ -----------------------------------------------------------------------
	: end-demo        ( -- )                  \ close the demo window
                Close: 滑鼠 ;
	: demo  ( -- )                  \ start running the demo program
        	Start: 滑鼠
        	;
	demo