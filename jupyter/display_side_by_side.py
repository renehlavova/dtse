## define functions to display cell outputs side by side
from IPython.display import display_html

## function to display two or more styled dataframes (Styler) side by side 
def display_side_by_side_styler(*args):
    html_str=''
    for df in args:
        html_str+=df.render()
    display_html(html_str.replace('table','table style="display:inline"'),raw=True)
    
## function to display two or more basic dataframes (Dataframe) side by side 
def display_side_by_side_df(*args):
    html_str=''
    for df in args:
        html_str+=df.to_html()
    display_html(html_str.replace('table','table style="display:inline"'),raw=True)