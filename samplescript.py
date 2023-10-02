from selenium import webdriver
from selenium.webdriver.common.by import By

driver = webdriver.Chrome()
driver.get('https://www.nasa.gov')
headlines = driver.find_elements(By.CLASS_NAME, "cards--card")
for headline in headlines:
    print(headline.text.strip())
driver.close()
