import requests

url = "https://apply-to-avantos.dev-sandbox.workload.avantos-ai.net"
headers = {
    "Content-Type": "application/json",
    "User-Agent": "Mozilla/5.0"
}
payload = {"email": "tingelijah@gmail.com"}

response = requests.post(url, headers=headers, json=payload)
print(response.status_code)
print(response.text)
