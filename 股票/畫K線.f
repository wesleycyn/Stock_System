0 value 最低價
0 value 最高價
0 value 收盤價
0 value 開盤價
0 value 項序 
0 value 間距
0 value 價間隔

: 畫陽線 
        0xff 0 0 顏色變更  
        項序 間距 * 
        最高價 價間隔 /
        項序 間距 * 
        最低價 價間隔 /  
        Line: dc
        ;
        
: 畫陰線
        0xff 0xff 0xff 顏色變更
        項序 間距 * 
        最高價 價間隔 /
        項序 間距 * 
        最低價 價間隔 /
        Line: dc        
        ;
        
: 畫陽實體             
        項序 間距 * 間距 2 / - 
        開盤價 價間隔 /
        項序 間距 * 間距 2 / +
        收盤價 價間隔 / 
        LTRED FillArea: dc        
        ;     
        
: 畫陰實體        
        項序 間距 * 間距 2 / -
        收盤價 價間隔 /
        項序 間距 * 間距 2 / +
        開盤價 價間隔 / 
        LTBACK FillArea: dc  
        ;

: 畫k線 ( 項序 開盤價 最高價 最低價 收盤價 -- )
    開盤價 收盤價 > 
    if
      畫陽線    
      畫陽實體             
    else
      畫陰線  
      畫陰實體             
    then
    ;