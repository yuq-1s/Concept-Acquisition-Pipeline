#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
Author: xuwei
Email: 18810079020@163.com
File: get_exercise_info.py
Date: 2020/9/22 2:56 下午
'''

import jsonlines
import general_tools as gt

db = gt.SqlDataOp(label='mysql_hive', db='xt_hive')

query_list = db.get_dict_sql("""
SELECT
	exercise_title,
	content,
	answer,
	problem_type_en
FROM
	dim_exerciseproblem_f
WHERE
	exercise_id IN ( SELECT DISTINCT exercise_id FROM dwd_classroom_exerciseleaf_f WHERE classroom_id IN ( SELECT DISTINCT classroom_id FROM dim_classroom_f WHERE course_name LIKE '%%数据结构%%' ) );

	""")


# content = gt.load_json(query_list[0]['content'].replace('\n', ''))
with jsonlines.open('results/exercise_dsa.jsonl', mode='w') as writer:
    for q in query_list:
        foo = gt.load_json(q['content'].replace('\n', ''))
        if not foo:
            continue
        writer.write(foo)
# print(content)
# print(type(content))

# content_dict = gt.load_json(gt.dump_json(content))
# for val in content_dict:
#     print(val)
