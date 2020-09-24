# coding: utf-8
cleanr = re.compile('<.*?>|&([a-z0-9]+|#[0-9]{1,6}|#x[0-9a-f]{1,6});')
clr = lambda x: re.sub(cleanr, '', x)
foo = []
with jsonlines.open('results/exercise_dsa.jsonl') as reader:
    for obj in reader:
        if 'Options' not in obj:
            continue
        foo.append({'body': clr(obj['Body']), 'options': {o['key']: clr(o['value']) for o in obj['Options']}, 'answer': obj['Answer']})
        
