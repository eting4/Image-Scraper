from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
import requests
import os

# Set up headless Chrome options
options = Options()
options.add_argument('--headless')
options.add_argument('--disable-gpu')  
options.add_argument('--window-size=1920,1080')

# Launch headless browser
driver = webdriver.Chrome(options=options)
driver.get("https://readvagabond-manga.online/manga/vagabond-chapter-327/")
print("Page title:", driver.title)

# Find all img elements
img_elements = driver.find_elements(By.TAG_NAME, 'img')

# Extract src attributes
img_urls = [img.get_attribute('src') for img in img_elements if img.get_attribute('src')]

# Close the browser
driver.quit()

# Display all image URLs
print(f"\nFound {len(img_urls)} images:")
for url in img_urls:
    print(url)

# Optional: Save images locally
# os.makedirs("vagabond_images", exist_ok=True)
# for i, url in enumerate(img_urls):
#     try:
#         response = requests.get(url, timeout=10)
#         if response.status_code == 200:
#             with open(f"vagabond_images/image_{i+1}.jpg", "wb") as f:
#                 f.write(response.content)
#     except Exception as e:
#         print(f"Failed to download image {i+1}: {e}")
