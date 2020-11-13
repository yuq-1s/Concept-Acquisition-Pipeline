import logging
import json
import csv

def get_video_ids(course_id):
    with open('data/entities/course.json') as f:
        for line in f:
            item = json.loads(line)
            if item['id'] == course_id:
                return item['video_order']
    print(f"[!] {course_id} not found")
    return []

def get_video_info(video_ids):
    videos = []
    with open('data/entities/video.json') as f:
        for line in f:
            item = json.loads(line)
            if item['id'] in video_ids and 'text' in item:
                videos.append({'id': item['id'], 'name': item['name'], 'text': '。'.join(item['text'])})
    return videos

def load_section_titles():
    with open('results/video_titles_new.csv') as f:
        reader = csv.reader(f)
        next(reader)
        for row in reader:
            yield ('V_'+row[2], row[7])

def load_id_map():
    with open('results/video_titles_new.csv') as f:
        reader = csv.reader(f)
        next(reader)
        for row in reader:
            yield (row[8], 'C_'+row[0])
        # yield ('696679', 'C_course-v1:TsinghuaX+20220214X+2018_T2')
        yield ('696679', 'C_course-v1:TsinghuaX+20220214X+2019_T1')

if __name__ == '__main__':
    id_map = dict(load_id_map())
    while True:
        new_xuetang_id = input()
        if new_xuetang_id not in id_map:
            print(f"[!] {new_xuetang_id} not found")
            continue
        old_id = id_map[new_xuetang_id]
        section_titles = dict(load_section_titles())
        with open(f'results/subtitle_{new_xuetang_id}.json', 'w') as f:
            for info in get_video_info(get_video_ids(old_id)):
                if info['id'] not in section_titles:
                    logging.warning(f"title of video {info['id']} not found")
                info['section_title'] = section_titles.get(info['id'], 'NOT_FOUND')
                f.write(json.dumps(info, ensure_ascii=False) + '\n')
        print(new_xuetang_id, "finished")
