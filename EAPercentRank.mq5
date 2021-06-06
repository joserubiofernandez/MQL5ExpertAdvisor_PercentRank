//+------------------------------------------------------------------+
//|                                       Percent Rank Expert Advisor|
//|                                                                  |
//|                                                                  |
//+------------------------------------------------------------------+
#property version   "1.00"

//+------------------------------------------------------------------+
//| Include                                                          |
//+------------------------------------------------------------------+

#include <OptimizacionLotes.mqh>
#include <StopLossTakeProfit.mqh>
#include <allowCompra.mqh>
#include <Indicadores.mqh>
CADX adx;
//+------------------------------------------------------------------+
//| Inputs                                                           |
//+------------------------------------------------------------------+
input int historicoCopyRates = 21;                       //Price history
input int periodADX = 14;                                //Adx Period
input int periodAtr = 14;                                //Atr Period
input ENUM_TIMEFRAMES timeFrame = PERIOD_CURRENT;        //TimeFrame for indicators
input int adxLimite = 20;                                //Adx Limit
input double risk_ = 0.01;                               //Risk per Trade
input double maxLoss_ = 500;                             //Maximum loss calculated in euros 
input double mult = 2;                                   //Atr multiplier
input int shift = 1;                                     //Candle calculate SL & TP
input double percentil = 75.0;                           //Percentil Rank
input string coment = "Percent Rank EA Buy";

//+------------------------------------------------------------------+
//| Global Variables                                                 |
//+------------------------------------------------------------------+
int magicNumb = 05062021;                                //Expert Advisor ID
MqlRates priceInfo[];                                    //Array Price
double askPrice = NULL;                                  //Ask Price
double lots_ = NULL;                                     //Lots
double sL = NULL;                                        //Stop Loss
double tP = NULL;                                        //Take Profit

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   ArraySetAsSeries(priceInfo,true);                  //Array elements indexing
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   if(CopyRates(_Symbol,PERIOD_CURRENT,0,historicoCopyRates,priceInfo)<0){ PrintFormat("Error en la copia de Rates Diarios, codigo %d", GetLastError());return;} //Copy Price Values
   
   adx.Init(_Symbol,timeFrame,periodADX);                                                                                                                        //Initialization of the Adx indicator 
  
   askPrice = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);                                                                                     //Ask price statement
   
  
   lots_ = optimalLots(risk_,maxLoss_);                                                                                                                          //Lots calculation
  
   sL = stopLossVolatilidadCompra(_Symbol,timeFrame,periodAtr,mult,shift);                                                                                       //Stop Loss calculation
   tP = takeProfitVolatilidadCompra(_Symbol,timeFrame,periodAtr,mult,shift);                                                                                     //Take Profit calculation
   
   
   if(allowTradea(magicNumb)== true )                                                                                                                            //Allow trade
        {
  
         if(buy()== true)
           {

            trade.Buy(lots_,_Symbol,askPrice,askPrice-MathAbs(sL),askPrice+MathAbs(tP),coment);                                                                  //Send trade parameters
            
           }
        }
}
//+------------------------------------------------------------------+
//|Percentil Rank Function                                           |
//+------------------------------------------------------------------+
  double percentilRank(double percentilBuscado)                                                                                                                  //Percentil Calculation
  {

   double copia[historicoCopyRates-1] ;
   double indice;

   for(int i=0; i<historicoCopyRates-1; i++)
     {
      copia[i]= priceInfo[i].close;

     }
   indice = (percentilBuscado/100)*(historicoCopyRates-1);
   ArraySort(copia);


   return(copia[(int)indice]);
  }
  
  
//+------------------------------------------------------------------+
//| Buy function                                                     |
//+------------------------------------------------------------------+
  bool buy()                                                                                                                                                  //When the following conditions are met, the purchase will be allowed
  {
   if(adx.Main()>adxLimite && priceInfo[1].close > percentilRank(percentil))
     {
      return true;
     }
   else
     {
      return false;
     }
  }

  
  

