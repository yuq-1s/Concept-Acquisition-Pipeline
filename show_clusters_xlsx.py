import xlsxwriter
import config
import json

def write_to_xlsx(concepts, filename):
    workbook = xlsxwriter.Workbook(filename)
    worksheet = workbook.add_worksheet()
    worksheet.set_column('A:O', 20)
    for i, c in enumerate(concepts):
        worksheet.write(i, 0, c['name'])
    workbook.close()

def write_to_xlsx_by_cluster(clusters, filename):
    workbook = xlsxwriter.Workbook(filename)
    worksheet = workbook.add_worksheet()
    worksheet.set_column('A:O', 20)
    for j, (_, concepts) in enumerate(sorted(clusters.items(), key=lambda x: x[0])):
        for i, c in enumerate(concepts):
            worksheet.write(i, j, c['name'])
    workbook.close()

if __name__ == '__main__':
    clusters = {}
    with open(config.cluster_save_path) as f:
        for line in f:
            obj = json.loads(line)
            if obj['cluster'] in clusters:
                clusters[obj['cluster']].append(obj)
            else:
                clusters[obj['cluster']] = [obj]
    write_to_xlsx_by_cluster(clusters, config.xlsx_save_path)
