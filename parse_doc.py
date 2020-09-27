import zipfile
import sys
from xml.dom import minidom

# TODO: 去掉中文之间的空格，去掉重复的句号，或逗号后面接句号

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

def collect_concepts(xml_string):
    for paragraph in minidom.parseString(xml_string).getElementsByTagName('w:p'):
        concepts = list(parse_one_paragraph(paragraph))
        text = ''.join(extract_paragraph(paragraph))
        if concepts:
            yield (text, set(concepts))

if __name__ == '__main__':
    document = zipfile.ZipFile(sys.argv[1])
    print(len(list(collect_concepts(document.read('word/document.xml')))))
