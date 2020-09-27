import pandas as pd
import fire

def main(filename: str):
    df = pd.read_excel(filename)
    bar = {}
    for word, importance in zip(df['候选概念'], df['标记类别']):
        bar[word] = importance

if __name__ == '__main__':
    fire.Fire(main)
