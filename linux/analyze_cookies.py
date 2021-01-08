import selenium.webdriver
import argparse

# run with python3

#todo: this does not handle wrong user input gracefully
parser = argparse.ArgumentParser(description='analyze cookies for secure and httpOnly attributes')
parser.add_argument('geckodriver')
parser.add_argument("host")
args=parser.parse_args()

# geckodriver downloaded from https://github.com/mozilla/geckodriver/releases
driver = selenium.webdriver.Firefox(executable_path = args.geckodriver)
driver.get(args.host)

cookies_list = driver.get_cookies()

print("***************************************************")
print("secure   = cookies with secure flag set, can never be sent over HTTP.")
print("           this is a must")
print("httpOnly = cookies with httpOnly flag set cannot be read from JS.")
print("           this is a may as that might be needed for tracking")
print("***************************************************")

for cookie in cookies_list:
    if cookie['httpOnly'] == False: 
        print("WARN!!!!!! httpOnly set to False")
    if cookie['secure'] == False:
        print("WARN!!!!!! secure set to False")
    print (cookie['name'],cookie['value'],cookie['httpOnly'],cookie['secure'],cookie['domain'])
    
    print("***")

driver.quit()
