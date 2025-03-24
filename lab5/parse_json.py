import json
import pandas as pd

# Load JSON data from given path
with open('../data/schacon.repos.json', 'r') as file:
    data = json.load(file)

# Extract required fields
repos_data = []
for repo in data[:5]:
    repos_data.append({
        'name': repo['name'],
        'html_url': repo['html_url'],
        'updated_at': repo['updated_at'],
        'visibility': repo['visibility']
    })

# Create DataFrame
df = pd.DataFrame(repos_data)

# Export to CSV without header/index
df.to_csv('chacon.csv', header=False, index=False)
