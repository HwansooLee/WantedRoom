import pandas as pd
fileName = 'storeData.csv'
storeData = pd.read_csv(fileName, encoding='euc-kr')
print(storeData)