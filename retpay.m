function ret = retpay(~)
%This program calculates the yearly pay one would expect in retirement as
%well as their total retirement savings based on their average interest
%rate, the years they were investing, and their annual investment amount.
clc

infl = .0322; %rate of inflation
retYears = 100-69; %years of retirement to enjoy
interestW = .07; %average interest rate while working
interestR = .04; %average interest rate while retired
years = 69-25; %years working
investment = 12000; %investment per year
retpayE = 1000;
wanted = 50000; %Annual pay after retirement

while retpayE < wanted 
    investment = investment + 1;
    retTot = (investment * ((1+ interestW)^years - 1)/interestW);
    retTotEf = retTot/(1+infl)^years;
    retpayE = retTotEf/retYears;
    retpay = retTot/retYears;
    
    for i = 1:retYears
        interest = ((1 + interestR)/(1 + infl))^(i);
        if i == 1
            retTotEf = retTotEf*interest;
        else
            retTotEf = retTotEf*interest - EFFECTIVE_SALARY(i-1,1)*i;
        end
        retpay = retTotEf/retYears;
        EFFECTIVE_SALARY(i,1) = retpay;
    end
    
end

monthly = investment/12;

YEARS_AFTER_RETIREMENT = (1:retYears)';

Type = categorical({'Years Working';'Yearly Investment';'Monthly Investment';
    'Total Savings';'Yearly Income';'Purchasing power of Savings'});
Value = [years;investment;monthly;retTot;retpay;retTotEf];

SUMMARY_TABLE = table(Type,Value)
%EFFECTIVE_RETIREMENT_PAY = table(YEARS_AFTER_RETIREMENT,EFFECTIVE_SALARY)
plot(YEARS_AFTER_RETIREMENT,EFFECTIVE_SALARY,'b--')
xlabel('Years After Retirement')
ylabel('Effective Salary')

end
