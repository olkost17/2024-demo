# The following code to create a dataframe and remove duplicated rows is always executed and acts as a preamble for your script: 

# dataset = pandas.DataFrame(undefined, undefined.1, undefined.2, undefined.3, undefined.4, undefined.5, undefined.6, undefined.7, undefined.8, undefined.9, undefined.10, undefined.11, undefined.12, undefined.13, undefined.14, undefined.15, undefined.16, undefined.17, undefined.18, undefined.19, undefined.20, undefined.21, undefined.22, undefined.23, undefined.24, undefined.25, undefined.26, undefined.27, undefined.28, undefined.29)
# dataset = dataset.drop_duplicates()

# Paste or type your script code here:
# Import the necessary libraries
import pandas as pd
import matplotlib.pyplot as plt

# The 'dataset' DataFrame is automatically provided by Power BI
if not dataset.empty:
    total_rows = len(dataset)
    null_counts = dataset.isnull().sum()
    # Calculate blank (empty string) counts and caseinsensitive trimmed "unknown" counts
    blank_counts = (dataset == '').sum() + (dataset.applymap(lambda x: isinstance(x, str) and x.strip().lower() == 'unknown')).sum()
    
    null_counts += blank_counts
    null_percentages = (null_counts / total_rows) * 100
    sorted_percentages = null_percentages.sort_values(ascending=True)
    
    # --- NEW: Intelligent title logic ---
    # Check for the number of unique order types in the filtered data
    if 'order_type' in dataset.columns:
        unique_types = dataset['order_type'].unique()
        if len(unique_types) == 1:
            # If there is exactly one type, display its name
            title_text = f"'{unique_types[0]}'"
        else:
            # If there are multiple (or no) selections, display a generic title
            title_text = "Multiple Selections"
    else:
        title_text = "Analysis" # Fallback if column is missing

    # Use the new title_text variable to build the output
    output_text = f"Blank Row Percentage for Order Type: {title_text}\n"
    output_text += "-" * 60 + "\n\n"
    
    for column, percentage in sorted_percentages.items():
        padding_width = 30 
        output_text += f"{column.ljust(padding_width)} : {percentage:.2f}%\n"

    # --- Display the text output in the visual ---
    fig, ax = plt.subplots(figsize=(8, 15))
    
    ax.text(0.0, 1, output_text, 
            ha='left', 
            va='top', 
            fontsize=20,
            fontfamily='monospace')
            
    ax.axis('off')
    plt.show()

else:
    # Handle the case where the dataset is empty (e.g., a slicer combination with no data)
    import matplotlib.pyplot as plt
    fig, ax = plt.subplots()
    ax.text(0.5, 0.5, "No data available for the selected 'order_type'.", 
            ha='center', va='center', fontsize=12)
    ax.axis('off')
    plt.show()