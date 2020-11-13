import zipfile
import copy
import re
import sys
from xml.dom import minidom

chinese_pattern = '\u4e00-\u9fa5。\.,，:：《》、\(\)（）'

def get_text(node):
    textnode = node.getElementsByTagName('w:t')
    assert len(textnode) == 1
    return textnode[0].childNodes[0].toxml()

def merge_highlights(paragraph, node):
    next_sibling = node.nextSibling
    while type(next_sibling) is minidom.Text or next_sibling.tagName != 'w:r':
        paragraph.removeChild(next_sibling)
        next_sibling = node.nextSibling
    if next_sibling is not None and next_sibling.getElementsByTagName('w:highlight'):
        node_value = node.getElementsByTagName('w:t')[0].childNodes[0].nodeValue
        sibling_value = next_sibling.getElementsByTagName('w:t')[0].childNodes[0].nodeValue
        node.getElementsByTagName('w:t')[0].childNodes[0].nodeValue += sibling_value
        paragraph.removeChild(next_sibling)
        merge_highlights(paragraph, node)

def parse_one_paragraph(paragraph):
    for child in paragraph.childNodes:
        if hasattr(child, 'getElementsByTagName') and child.getElementsByTagName('w:highlight'):
            merge_highlights(paragraph, child)
            yield get_text(child)

def extract_paragraph(paragraph):
    for child in paragraph.getElementsByTagName('w:t'):
        yield child.childNodes[0].nodeValue.strip()

def windowed_text(text, deliminator='。', n_window=3):
    text = text.split(deliminator)
    foo = text[:n_window]
    for thing in text[n_window:]:
        yield copy.copy(foo)
        foo.pop(0)
        foo.append(thing)
    yield foo

def process_text(text):
    text = text.replace('。。', '。')
    text = text.replace('，。', '，')
    text = re.sub(' *(['+chinese_pattern+']{1}) *', '\\1', text)
    return text

def collect_concepts(xml_string):
    for paragraph in minidom.parseString(xml_string).getElementsByTagName('w:p'):
        concepts = list(parse_one_paragraph(paragraph))
        text = process_text(''.join(extract_paragraph(paragraph)))
        if concepts:
            for wt in windowed_text(text):
                yield ('，'.join(wt) + '。', set(concepts))

def iob_label(ret, start, end):
    '''
    >>> a = ['O' for _ in range(8)]
    >>> iob_label(a, 1, 2)
    ['O', 'S-CONC', 'O', 'O', 'O', 'O', 'O', 'O']
    >>> a = ['O' for _ in range(8)]
    >>> iob_label(a, 1, 3)
    ['O', 'B-CONC', 'E-CONC', 'O', 'O', 'O', 'O', 'O']
    >>> a = ['O' for _ in range(8)]
    >>> iob_label(a, 1, 4)
    ['O', 'B-CONC', 'M-CONC', 'E-CONC', 'O', 'O', 'O', 'O']
    '''
    assert start < end
    if end == start + 1:
        ret[start] = 'S-CONC'
    else:
        if end > start + 2:
            for i in range(start+1, end-1):
                ret[i] = 'M-CONC'
        ret[start] = 'B-CONC'
        ret[end-1] = 'E-CONC'
    return ret


def match_concepts(paragraph, concepts):
    ret = ['O' for _ in paragraph]
    for concept in concepts:
        pattern = re.compile(concept)
        for m in re.finditer(pattern, paragraph):
            if not ret[m.start()] == 'O':
                continue
            iob_label(ret, m.start(), m.end())
    return ret

def exact_match_score(paragraph, correct_concepts, course_concepts):
    from sklearn.metrics import f1_score, precision_score, recall_score
    label = match_concepts(correct_concepts)
    prediction = match_concepts(course_conceps)
    print('p\t', precision_score(label, prediction))
    print('r\t', recall_score(label, prediction))
    print('f1\t', f1_score(label, prediction))

if __name__ == '__main__':
    import doctest
    doctest.testmod()
    document = zipfile.ZipFile(sys.argv[1])
    for p, c in collect_concepts(document.read('word/document.xml')):
        labels = match_concepts(p, c)
        assert len(p) == len(labels)
        # FIXME: avl树，"a v l" 被分开了
        for char, label in zip(p, labels):
            print(char, label)
        print()
