
#include <Trade\Trade.mqh>
CTrade trade;
//+------------------------------------------------------------------+
//|Trade Allow                                                       |
//+------------------------------------------------------------------+

bool allowTradea(int magicNumber){
   trade.SetExpertMagicNumber(magicNumber);
   bool tradear = true;
   bool position_actual = PositionSelect(_Symbol);
   if(position_actual == true && PositionGetInteger(POSITION_MAGIC)== magicNumber)
     {
      tradear = false;
     }
return tradear;}

//We can only trade if there are no open trades