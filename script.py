from flask import Flask, jsonify, request
from bs4 import BeautifulSoup
import requests

app = Flask(__name__)

# Extract image URLs from a chapter page
def extract_images(link):
    response = requests.get(link)
    soup = BeautifulSoup(response.text, 'html.parser')
    img_elements = soup.find_all('img')
    img_urls = [img['src'] for img in img_elements if img.get('src')]
    return img_urls

# Extract chapter links from a main index page
def load_chapters(link):
    response = requests.get(link)
    soup = BeautifulSoup(response.text, 'html.parser')
    chapter_urls = []
    for a in soup.find_all('a', href=True):
        href = a['href']
        if 'chapter' in href:
            chapter_urls.append(href)
    return chapter_urls

# Route for extracting image links
@app.route('/extract-images', methods=['GET'])
def extract_images_endpoint():
    link = request.args.get('link')
    if not link:
        return jsonify({"error": "No link provided"}), 400
    try:
        images = extract_images(link)
        return jsonify({"images": images})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Route for loading chapters
@app.route('/load-chapters', methods=['GET'])
def load_chapters_endpoint():
    link = request.args.get('link')
    if not link:
        return jsonify({"error": "No link provided"}), 400
    try:
        chapters = load_chapters(link)
        return jsonify({"chapters": chapters})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Run the Flask app
if __name__ == '__main__':
    app.run(debug=True)
