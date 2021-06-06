//+------------------------------------------------------------------+
//|    Lotage calculation                                            |
//+------------------------------------------------------------------+
  
  
  double optimalLots(double risk,double maxLoss){
   double Equity_ = AccountInfoDouble(ACCOUNT_EQUITY);
   double lotes;
      
      lotes = NormalizeDouble((risk*Equity_)/maxLoss,2);
      return MathAbs(lotes);
  
  }
  