import openpyxl
import json
import config

def get_highlighted_concepts(sheet):
    for row in sheet.iter_rows():
        for cell in row:
            if cell.fill.start_color.index not in ['00000000', 0]:
                if cell.value.strip():
                    yield cell.value.strip()

def main():
    wb = openpyxl.load_workbook(config.xlsx_save_path)
    sheet = wb['Sheet1']
    concepts = list(get_highlighted_concepts(sheet))
    if concepts:
        with open(config.annotation_save_path, 'w') as f:
            for concept in concepts:
                f.write(concept + '\n')

if __name__ == "__main__":
    main()
