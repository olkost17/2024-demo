import re
import json

# Read the Layout file with UTF-16LE encoding
with open(r"c:\Users\oleksandr_kostenko3\Documents\PowerBI\unpack_pbix\CHMO RM Core Pilot - New Version SM_v5_11\Report\Layout", 'r', encoding='utf-16le') as f:
    content = f.read()

titles = set()

# Parse the JSON properly
try:
    layout_json = json.loads(content)
    
    # Function to recursively extract text from config strings
    def extract_from_config(config_str):
        try:
            # Unescape and parse the nested JSON
            config_obj = json.loads(config_str)
            
            # Navigate to textbox visuals
            if isinstance(config_obj, dict):
                single_visual = config_obj.get('singleVisual', {})
                if single_visual.get('visualType') == 'textbox':
                    objects = single_visual.get('objects', {})
                    general = objects.get('general', [])
                    for gen in general:
                        props = gen.get('properties', {})
                        paragraphs = props.get('paragraphs', [])
                        for para in paragraphs:
                            text_runs = para.get('textRuns', [])
                            for run in text_runs:
                                value = run.get('value', '').strip()
                                # Skip empty, whitespace-only, or tab-only strings
                                if value and not re.match(r'^[\s\t]+$', value):
                                    titles.add(value)
        except:
            pass
    
    # Extract from sections
    def process_section(obj):
        if isinstance(obj, dict):
            # Check for config string
            if 'config' in obj and isinstance(obj['config'], str):
                extract_from_config(obj['config'])
            # Recursively process nested objects
            for value in obj.values():
                if isinstance(value, (dict, list)):
                    process_section(value)
        elif isinstance(obj, list):
            for item in obj:
                process_section(item)
    
    process_section(layout_json)
    
except Exception as e:
    print(f"Error parsing JSON: {e}")

# Sort the titles
sorted_titles = sorted(titles)

# Write to file
with open(r"c:\Users\oleksandr_kostenko3\python_1\static_titles.txt", 'w', encoding='utf-8') as f:
    for title in sorted_titles:
        f.write(title + '\n')

print(f"Extracted {len(sorted_titles)} unique static titles")
print("\nFirst 30 titles:")
for i, title in enumerate(sorted_titles[:30], 1):
    print(f"{i}. {title}")
