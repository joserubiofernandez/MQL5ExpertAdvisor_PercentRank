

#define MAX_COUNT 100


//+------------------------------------------------------------------+
//| Class Indicator                                                  |
//+------------------------------------------------------------------+

class CI
{
	protected:
		int handle;
		double iValue[];
		
	public:
		CI(void);
		double Main(int shift_=0);
		void Release();
		virtual int Init() { return(handle); }
};

CI::CI(void)
{
	ArraySetAsSeries(iValue,true);
}

double CI::Main(int shift_=0)
{
	CopyBuffer(handle,0,0,MAX_COUNT,iValue);
	double value = NormalizeDouble(iValue[shift_],_Digits);
	return(value);
}

void CI::Release(void)
{
	IndicatorRelease(handle);
}


//+------------------------------------------------------------------+
//|Class ATR                                                         |
//+------------------------------------------------------------------+
class CATR : public CI
{
	public:
		int Init(string symbol__,ENUM_TIMEFRAMES timeframe__,int period__);
};

int CATR::Init(string symbol__,ENUM_TIMEFRAMES timeframe__,int period__)
{
	handle = iATR(symbol__,timeframe__,period__);
	return(handle);
}

//+------------------------------------------------------------------+
//|Class ADX                                                         |
//+------------------------------------------------------------------+

class CADX : public CI
{
   public:
		int Init(string symbol__,ENUM_TIMEFRAMES timeframe__,int period__);
};

int CADX::Init(string symbol__,ENUM_TIMEFRAMES timeframe__,int period__)
{
	handle = iADX(symbol__,timeframe__,period__);
	return(handle);
}