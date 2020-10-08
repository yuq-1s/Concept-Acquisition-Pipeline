import jsonlines
import csv
import fire

def read_csv(filename):
    with open(filename) as f:
        reader = csv.reader(f)
        next(reader)
        for row in reader:
            yield row[0], row[1]

def main(csv_filename: str = 'os_concepts_annotated.csv'):
    concepts = dict(read_csv(csv_filename))
    with jsonlines.open(f'{csv_filename}.jsonl', mode='w') as writer:
        for concept, importance in concepts.items():
            if int(importance) == 2:
                writer.write({'name': concept})

if __name__ == '__main__':
    fire.Fire(main)
