
#include <Indicadores.mqh>
CATR ATR;

 //+-------------------------------------------------------------------+
  //|       Stop Loss based on volatility                              |
  //+------------------------------------------------------------------+
  
  double stopLossVolatilidadCompra(string symbol,ENUM_TIMEFRAMES TimeFrame, int period, double multiplicador, int shft) 
  {
   double ask = 0;
   double stop= 0;
   ATR.Init(symbol,TimeFrame,period);
   
   stop  = ask - (ATR.Main(shft) * multiplicador);
   return stop;}
  
   //+------------------------------------------------------------------+
  //|        Take Profit based on volatility                            |
  //+-------------------------------------------------------------------+

  double takeProfitVolatilidadCompra(string symbol,ENUM_TIMEFRAMES TimeFrame, int period, double multiplicador, int shft) 
  {
   double ask = 0;
   double stop= 0;
   ATR.Init(symbol,TimeFrame,period);
   ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
   
   stop  = ask + (ATR.Main(shft) * multiplicador);
   return stop;}
  
  
  //We will use the ATR indicator plus a multiplier to calculate the SL and TP