import zipfile
import sys
from xml.dom import minidom

def parse_one_paragraph(paragraph):
    for child in paragraph.childNodes:
        if hasattr(child, 'getElementsByTagName') and child.getElementsByTagName('w:highlight'):
            textnode = child.getElementsByTagName('w:t')
            assert len(textnode) == 1
            yield textnode[0].childNodes[0].toxml()

def collect_concepts(xml_string):
    for paragraph in minidom.parseString(xml_string).getElementsByTagName('w:p'):
        yield list(parse_one_paragraph(paragraph))

if __name__ == '__main__':
    document = zipfile.ZipFile(sys.argv[1])
    print(list(collect_concepts(document.read('word/document.xml'))))
