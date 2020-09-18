SELECT 
	xt_hive.api_course_video_basic.course_id,
    xt_hive.api_course_video_basic.course_name,
    xt_hive.api_course_video_basic.video_id,
    xt_hive.api_course_video_basic.video_name,
    xt_hive.dwd_classroom_videoleaf_f.chapter_id,
    xt_hive.dwd_classroom_videoleaf_f.chapter_title,
	xt_hive.dwd_classroom_videoleaf_f.section_id,
	xt_hive.dwd_classroom_videoleaf_f.section_title,
    data_map.course_id_map.course_id as new_course_id
FROM xt_hive.api_course_video_basic
join xt_hive.dwd_classroom_videoleaf_f on xt_hive.api_course_video_basic.ccid = xt_hive.dwd_classroom_videoleaf_f.ccid
join data_map.course_id_map on data_map.course_id_map.old_course_id = xt_hive.api_course_video_basic.course_id
where data_map.course_id_map.course_id in (676683,676932,677010,696597,697360,697791,735054,735351,770738,770784)
or xt_hive.api_course_video_basic.course_id in
("course-v1:McGillX+ATO185x+2015T1","course-v1:TsinghuaX+THESIS2015X+2015T1","course-v1:TsinghuaX+THESIS20141Xtv+2014","course-v1:TsinghuaX+THESIS2015Xtv+2015T1","course-v1:TsinghuaX+00690242+sp","course-v1:HNU+HNU001+sp","course-v1:TsinghuaX+00720091X+sp","course-v1:TsinghuaX+00612642X+sp","course-v1:TsinghuaX+00691153X+sp","course-v1:UQx+Think101x+sp","course-v1:TsinghuaX+JWWD001+2015T2","course-v1:TsinghuaX+70660542X+2015T2","course-v1:TsinghuaX+70120073X+sp","course-v1:PekingX+Peking001x+","course-v1:UST+UST001+sp","course-v1:SDUx+00931800X+sp","course-v1:TsinghuaX+00690212X+sp","course-v1:TsinghuaX+00680082X+sp","course-v1:TsinghuaX+30260112X+sp","course-v1:TsinghuaX+00310222X+sp","course-v1:BIT+PHY1701702+sp","course-v1:BIT+PHY1701701+sp","course-v1:TsinghuaX+80515522X+sp","course-v1:TsinghuaX+34000888X+sp","course-v1:TsinghuaX+00690092X+sp","course-v1:TsinghuaX+00690342X+sp","course-v1:TsinghuaX+20350033X+sp","course-v1:TsinghuaX+00740043X2015T2+sp","course-v1:TsinghuaX+007400432x2015T2+sp","course-v1:TsinghuaX+10610193X+sp","course-v1:Tsinghuax+30130123X+sp","course-v1:TsinghuaX+40050444X+sp","course-v1:TsinghuaX+30320174X+sp","course-v1:TsinghuaX+00460032X+sp","course-v1:BIT+PHY1701601+sp","course-v1:MicrosoftX+Microsoft101+sp","course-v1:BIT+PHY17016+sp","course-v1:TsinghuaX+MOO10120152+sp","course-v1:TsinghuaX+70250023X20152+sp","course-v1:TsinghuaX+10430484X20152+sp","course-v1:TsinghuaX+10430494X20152+sp","course-v1:TsinghuaX+20220053X2015T2+sp","course-v1:TsinghuaX+30150153X+sp","course-v1:TsinghuaX+10421075X20152+sp","course-v1:TsinghuaX+10421084X20152+sp","course-v1:TsinghuaX+20330334X20152+sp","course-v1:TsinghuaX+0350161X2015T2+sp","course-v1:TsinghuaX+10421102x2015T2+sp","course-v1:TsinghuaX+20430064X+sp","course-v1:TsinghuaX+20250103X+sp","course-v1:TsinghuaX+60240202X+sp","course-v1:TsinghuaX+10421094X20152+sp","course-v1:TsinghuaX+80150193X+sp","course-v1:TsinghuaX+30670043X+sp","course-v1:TsinghuaX+30150303X+sp","course-v1:AdelaideX+Wine101x+sp","course-v1:WellesleyX+HIST229x+sp","course-v1:MITx+6001x+sp","course-v1:MITx+153902x+sp","course-v1:WUT+WUT2016003+2016T2","course-v1:TsinghuaX+THESIS2016Xtv+2016T1","course-v1:TsinghuaX+30140393X+sp","course-v1:TsinghuaX+30240184+sp","course-v1:TsinghuaX+70167012X+sp","course-v1:BJUT+2140074001x+sp","course-v1:TsinghuaX+302401842X+sp","course-v1:TsinghuaX+30240243X+sp","course-v1:TsinghuaX+80000822X+sp","course-v1:BSU+BSU001+sp","course-v1:TsinghuaX+40050455X+sp","course-v1:MITx+6002x+sp","course-v1:TsinghuaX+60240013X+sp","course-v1:TsinghuaX+007401132X+sp","course-v1:UBerkeleyX+S1841x+sp","course-v1:TsinghuaX+TsinghuaMandarin01+sp","course-v1:TsinghuaX+80590952X+sp","course-v1:TsinghuaX+007401131X+sp","course-v1:UQx+BIOIMG101x+sp","course-v1:UQx+TROPI101x+sp","course-v1:TsinghuaX+20120143X+sp","course-v1:TsinghuaX+70150023X+sp","course-v1:RiceX+AdvENVSI1x+sp","course-v1:TsinghuaX+34100325X+sp","course-v1:TsinghuaX+400504552X+sp","course-v1:RiceX+BIO3721x+sp","course-v1:RiceX+BIO3722x+sp","course-v1:RiceX+AdvBIO1x+sp","course-v1:RiceX+AdvBIO2x+sp","course-v1:TsinghuaX+30040323X+sp","course-v1:RiceX+AdvBIO3x+sp","course-v1:edX+BlendedX+sp","course-v1:RiceX+AdvBIO4x+sp","course-v1:TsinghuaX+204300642X+sp","course-v1:RiceX+AdvENVSI2x+sp","course-v1:RiceX+AdvENVSI3x+sp","course-v1:Tsinghua+20150001+sp","course-v1:UQx+rime101x+sp","course-v1:TsinghuaX+00040132X+sp","course-v1:RiceX+RELI157x+sp","course-v1:TsinghuaX+00740123X+sp","course-v1:TsinghuaX+64100033X+SP","course-v1:TsinghuaX+60610231+2016T2SP","course-v1:JXUST+JXUST2016001+2016T2","course-v1:NJU+1026+2016T2","course-v1:ZUELX+B0800280+sp","course-v1:NB+NB000201+sp","course-v1:TsinghuaX+01030132X+sp","course-v1:DelftX+ET3034x+sp","course-v1:ZJUX+2017011101X+2017T1","course-v1:NUDT+125205501+sp","course-v1:WUT+1022817X+sp","course-v1:UST+2017011401X+2017T1","course-v1:UST+2017011402X+2017T1","course-v1:NUDT+2017011401X+2017T1","course-v1:TsinghuaX+80240372X+sp","course-v1:TsinghuaX+Thesis2016X+sp","course-v1:NTU+wghx+2017T1","course-v1:TsinghuaX+20440333X+sp","course-v1:TsinghuaX+00701032X+sp","course-v1:HUBU+HU08002X+sp","course-v1:HUBU+HU08003X+sp","course-v1:HUBU+20170227X+sp","course-v1:HUBU+2017022703X+sp","course-v1:TsinghuaX+2070071X+2017T1","course-v1:WUT+WUT2016001+sp","course-v1:BIT+BIT2016001+sp","course-v1:HUBU+2017030501X+sp","course-v1:HIT+HIT2016002+sp","course-v1:HIT+HIT2016001+sp","course-v1:TsinghuaX+80140242+sp","course-v1:TsinghuaX+81020142X+sp","course-v1:TsinghuaX+Pr20170406-Sp1+sp","course-v1:GXUST+2017041901X+2017T1","course-v1:BNU+GE410081071-01+2017T1","course-v1:FudanX+SOS120007+sp","course-v1:JNUX+07009156X+sp","course-v1:TsinghuaX+00690212X-2+sp","course-v1:ZUELX+B0601353+sp","course-v1:TsinghuaX+80000901X2+sp","course-v1:TsinghuaX+30640014X+sp","course-v1:McGillX+hem181x+sp","course-v1:TsinghuaX+30806872X+sp","course-v1:TsinghuaX+30700313X+sp","course-v1:SEU+00690803+sp","course-v1:TsinghuaX+10800163X+sp","course-v1:TsinghuaX+006903022+sp","course-v1:DYU+dyuwgzbbm+sp","course-v1:TsinghuaX+10800032X+sp","course-v1:WellesleyX+ANTH207x+sp","course-v1:TsinghuaX+80000901X1+sp","course-v1:TsinghuaX+80611322X+sp","course-v1:TsinghuaX+00612643X+sp","course-v1:TsinghuaX+90640012X+sp","course-v1:AA+MA1X+sp","course-v1:UPB+UPB201702+sp","course-v1:TsinghuaX+10610224X+sp","course-v1:SEU+00690803+Sp","course-v1:TsinghuaX+006903021+sp","course-v1:TsinghuaX+400182X+sp","course-v1:TsinghuaX+10691113X+sp","course-v1:RiceX+MedDigX+sp","course-v1:WageningenX+NUTR101x+sp","course-v1:AA+MA2X+sp","course-v1:TsinghuaX+20220332X+sp","course-v1:TsinghuaX+00670122X+sp","course-v1:TsinghuaX+THU201605X+sp","course-v1:TsinghuaX+02070251X+sp","course-v1:XJTU+ME-XMGL2013-014X+sp","course-v1:MIL+MIL2016001+sp","course-v1:JinanX+2017031001X+sp","course-v1:TsinghuaX+40260092X+sp","course-v1:TsinghuaX+106101832X+sp","course-v1:TsinghuaX+40160092X+sp","course-v1:TsinghuaX+TSINGHUA107+sp","course-v1:AdelaideX+humbio101+sp","course-v1:TsinghuaX+40990255X1+sp","course-v1:TsinghuaX+30040352X+sp","course-v1:TsinghuaX+70612463X+sp","course-v1:TsinghuaX+20250064X+sp","course-v1:FUDANx+EON1300812+sp","course-v1:TsinghuaX+00690863X+sp","course-v1:JSUX+2017011101X+sp","course-v1:TJU+2010241X+sp","course-v1:ZUEL+B0680090+sp","course-v1:AA+FA2X+sp","course-v1:AA+FA1X+sp","course-v1:HEBNU+2017011901X+sp","course-v1:Tsinghua+Thesis2017X+2017T1","course-v1:Ix+Spanish001+sp","course-v1:TsinghuaX+80000271X+sp","course-v1:HUBU+20170619001+sp","course-v1:ZJFF+000516+sp","course-v1:XJTU+OMP200853+sp","course-v1:HAUT+2017070701X+sp","course-v1:BNU+2017071001X+2017sp","course-v1:UEST+2017071301X+sp","course-v1:XJTU+PHLS100914+sp","course-v1:XJTU+00204+sp","course-v1:GZHU+000001004+sp","course-v1:GZHU+136300904+sp","course-v1:BJTU+2017072501X+sp","course-v1:NU+2017081001X+sp","course-v1:QU+IE20012+sp","course-v1:SPI+40281x+sp","course-v1:SPI+20170828001x+sp","course-v1:KMUSTX+8209001+sp","course-v1:EST+20170914+sp","course-v1:MITSLTLab+161x+sp","course-v1:TsinghuaX+20220332X1+2017T2","course-v1:HEBUT+20170921001+sp","course-v1:JNUX+jnu05011190X+sp","course-v1:SIT+2017092601+sp","course-v1:SUT+145055+sp","course-v1:JNU+07009215+sp","course-v1:SXPI+20171101002+sp","course-v1:YMY+20171108001+sp","course-v1:TsinghuaX+20250064+sp","course-v1:LZU+20171113+SP","course-v1:FAFU+20171121001+2017T1","course-v1:WHUT+20171128+sp","course-v1:UNY+20171211001+sp","course-v1:TsinghuaX+Thesis2018+sp","course-v1:JNU+07040146+2018T1","course-v1:RiceX+Phys102x+sp","course-v1:MITx+203x+sp","course-v1:UBerkeleyX+S1692x+sp","course-v1:cup+20180130+sp","course-v1:XIYOU+20180208+sp","course-v1:GZLIS+070200140+2018T1","course-v1:TsinghuaX+00670122+sp","course-v1:PasteurX+96008+sp","course-v1:LUIBE+2018030701+sp","course-v1:JNU+03010100+sp","course-v1:TsinghuaX+2018032801X+2018T1","course-v1:dlmu+20180330+sp","course-v1:dlmu+20180403+sp","course-v1:QHU+20180419+sp","course-v1:HNU+20180424001+2018T1","course-v1:MITSLTLab+162x+2018T1","course-v1:JNU+07009188+2018T2","course-v1:JNU+2018012501X+sp","course-v1:SUE+0171229001+sp","course-v1:SUT+145033+sp","course-v1:NJU+2018032001X+sp","course-v1:Stanford+WomensHealth+sp","course-v1:NJU+2018032002X+SP","course-v1:BerkeleyX+S1691X+sp","course-v1:NJU+37204001+2018T3","course-v1:SU+210102T10+sp","course-v1:SU+2018020201X+sp","course-v1:SU+210201T10+sp","course-v1:NEPU+20180628001+2018T2","course-v1:BJTU+2017052601X+2018T2","course-v1:I+ccioo1+2018T3","course-v1:ZUELX+B0601353+2018T2","course-v1:ZUELX+B0800280+2018T2","course-v1:TsinghuaX+20430054X1+sp","course-v1:TsinghuaX+20430054X1+sp","course-v1:TsinghuaX+20140064X+2018sp","course-v1:TsinghuaX+201400642X+2018sp","course-v1:NUDT+05028103+2018T2","course-v1:BNU+2017001+2018T2","course-v1:SJU+2018072301+sp","course-v1:SXPI+20171101005+2018T2","course-v1:NB+013G29A00+2018T2","course-v1:FAFU+20180104002+sp","course-v1:SUT+145055+2018T2","course-v1:SichuanU+304231020+sp","course-v1:ityU+GE2304+sp","course-v1:SU+82150112201+2018T2","course-v1:NEU+2018051501+sp","course-v1:SU+82150112201+sp","course-v1:UEST+E2216230+2018T2","course-v1:TsinghuaX+Intro2EltrMrt+2018T2","course-v1:SU+20180918X+2018T2","course-v1:gmc+30102+2018T2","course-v1:gmc+306702+2018t2","course-v1:jlu+20180925+2018T2","course-v1:NB+031J33B00+sp","course-v1:KMUSTX+1803168+2018T2","course-v1:Tsinghua+20181011X+2018T2","course-v1:gmc+3060511+2018T2","course-v1:PSFF+2018102402X+2018T2","course-v1:PSFF+2018102403X+2018T2","course-v1:PSFF+2018102404X+2018T2","course-v1:PSFF+2018102405X+2018T2","course-v1:PSFF+2018102406X+2018T2","course-v1:BNU+SL21148501+2018T2","course-v1:XJAU+246010007+2018T2","course-v1:JNU+077901mc08+2018T3","course-v1:YLVT+2018111301X+2018T2","course-v1:IMUN+5016105+2019T1","course-v1:HLJUX+1811012013+2018T2","course-v1:GIT+0500002402+2018T2","course-v1:BNU+SL21126882+2019T1","course-v1:SWPU+3615001035+2019T1","course-v1:BNU+2017112001X+2019T1","course-v1:SHZU+Z104021+2019T1","course-v1:TsinghuaX+60700052X+2019T1","course-v1:LinuxFoundationX+Linux001+sp","course-v1:TsinghuaX+70150104X+2019T1","course-v1:TsinghuaX+701501042X+2019T1","course-v1:BNU+GOV21089621+2019T1","course-v1:SDSNAssociation+ASD+sp","course-v1:WUT+WUT2016001+2019T1","course-v1:WUST+20180821002X+2019T1","course-v1:BNU+2018091301X+2019T1","course-v1:BNU+2018091303X+2019T1","course-v1:JNUX+2018120406X+2018T2","course-v1:NEU+20181206X+2018T2","course-v1:QHU+20180419+2019T1","course-v1:BNU+2018091304X+2019T1","course-v1:BNU+2018091305X+2019T1","course-v1:ZZU+2018032501X+2019T1","course-v1:BNU+2018091302X+2019T1","course-v1:TsinghuaX+80240372X+2019T1","course-v1:SDSNAssociation+PB+sp","course-v1:HNU+20180529001+2019T1","course-v1:TsinghuaX+01510192X+2019T1","course-v1:qhnu+20181212x+2018T2","course-v1:IE+IE2016005+2019T1","course-v1:IE+IE2017005+2019T1","course-v1:ZZU+20180116001+2019T1","course-v1:IE+IE2017008+2019T1","course-v1:XJTU+2018121301X+2018T2","course-v1:IE+IE2016004+2019T1","course-v1:IE+IE2017004+2019T1","course-v1:WUT+1022817X+2019T1","course-v1:IE+JD2017+2019T1","course-v1:MITx+153902x+2019T1","course-v1:IE+IE2017002+2019T1","course-v1:IE+IE2017001+2019T1","course-v1:IE+IE2016002+2019T1","course-v1:BNU+GE410081071-01+2019T1","course-v1:HIT+HIT2016001+2019T1","course-v1:BNU+ENV21105101+2019T1","course-v1:TsinghuaX+00510663X+2019T1","course-v1:TsinghuaX+00690242X+2019T1","course-v1:FZXY+20171127004+2019T1","course-v1:TsinghuaX+00040132X+2019T1","course-v1:TsinghuaX+00691153X+2019T1","course-v1:TsinghuaX+10800163X+2019T1","course-v1:TsinghuaX+00670122X+2019T1","course-v1:TsinghuaX+30806872X+2019T1","course-v1:SDSNAssociation+SN+sp","course-v1:SDSNAssociation+ED001+sp","course-v1:SDSNAssociation+21001+sp","course-v1:SDSNAssociation+TOW001+sp","course-v1:SDSNAssociation+S001+sp","course-v1:TsinghuaX+10800032X+2019T1","course-v1:TsinghuaX+00670122+2019T1","course-v1:TsinghuaX+THU201605X+2019T1","course-v1:TsinghuaX+30805743+2019T1","course-v1:TsinghuaX+40510293X+2019T1","course-v1:TsinghuaX+30670043X+2019T1","course-v1:TsinghuaX+00740123X+2019T1","course-v1:TsinghuaX+2018031901X+2019T1","course-v1:HNU+GE14068+2019T1","course-v1:TsinghuaX+10691113X+2019T1","course-v1:FJNU+5000320201+2019T1","course-v1:HUBU+20170227X+2019T1","course-v1:TsinghuaX+00510133X+2019T1","course-v1:TsinghuaX+00720091X+2019T1","course-v1:TsinghuaX+30240532X+2019T1","course-v1:YSU+20180301002+2019T1","course-v1:MU+24040004+2019T1","course-v1:TsinghuaX+20150001+2019T1","course-v1:TsinghuaX+00612642X+2019T1","course-v1:MU+2018031801X+2019T1","course-v1:TsinghuaX+70612463X+2019T1","course-v1:TsinghuaX+00690863X+2019T1","course-v1:TsinghuaX+00612643X+2019T1","course-v1:MU+050104+2019T1","course-v1:UQx+Think101x+2019T1","course-v1:KMUSTX+1193004+2019T1","course-v1:KMUSTX+1153036+2019T1","course-v1:KMUSTX+2018091101X+2019T1","course-v1:LZU+2018122505X+2018T2","course-v1:XJTU+2018122507X+2018T2","course-v1:YIT+2018122509X+2018T2","course-v1:TsinghuaX+400182X+2019T1","course-v1:YLVT+2018122511X+2018T2","course-v1:WU+2018122606X+2018T2","course-v1:BUM+2018122604X+2018T2","course-v1:HBPU+20181226006X+2018T2","course-v1:TsinghuaX+00310222X+2019T1","course-v1:qdu+2018122608X+2018T2","course-v1:BNU+2018122603X+2018T2","course-v1:TsinghuaX+60250131X+2019T1","course-v1:TsinghuaX+80590892+2019T1","course-v1:TsinghuaX+34000888X+2019T1","course-v1:HUBU+HU08002X+2019T1","course-v1:HNU+AR03015+2019T1","course-v1:TsinghuaX+007400431x+2019T1","course-v1:QU+2018122703+2018T2","course-v1:BFU+2018122709+2018T2","course-v1:nxu+2018122711+2018T2","course-v1:TsinghuaX+007400432x+2019T1","course-v1:BSU+BSU001+2019T1","course-v1:TsinghuaX+40809644X+2019T1","course-v1:SUT+2018122802X+2018T2","course-v1:TsinghuaX+20220332X+2019T1","course-v1:TsinghuaX+40140632X+2019T1","course-v1:TsinghuaX+30240233X+2019T1","course-v1:TsinghuaX+20220214X+2019T1","course-v1:HUBU+20170914001+2019T1","course-v1:TsinghuaX+40050444X+2019T1","course-v1:HEBUT+20180301001+2019T1","course-v1:TsinghuaX+70000662+2019T1","course-v1:TsinghuaX+2017091801X+2019T1","course-v1:BIFT+2018122901X+2018T2","course-v1:BIFT+2018122902X+2018T2","course-v1:TsinghuaX+2018011901X+2019T1","course-v1:UIR+2018040201X+2019T1","course-v1:SU+SU002+2019T1","course-v1:HQU+20180307009+2019T1","course-v1:SXPI+20170828001x+2019T1","course-v1:SXPI+40281x+2019T1","course-v1:LUIBE+2018080602+2019T1","course-v1:LUIBE+201808064+2019T1","course-v1:LUIBE+2018080601+2019T1","course-v1:LUIBE+201808063+2019T1","course-v1:snnu+20180920X+2019T1","course-v1:SXPI+20180919X+2019T1","course-v1:SU+2018020101X+2019T1","course-v1:TsinghuaX+10421094X+2019T1","course-v1:SU+20180910X+2019T1","course-v1:NJU+2018041201X+sp","course-v1:XIYOU+20180208+2019T1","course-v1:TsinghuaX+laserapp+2019T1","course-v1:HIT+13S20301820+2019T1","course-v1:HD+20180622001+2019T1","course-v1:AA+MA1X+2019T1","course-v1:AA+MA2X+2019T1","course-v1:TsinghuaX+10690012+2019T1","course-v1:BFU+15002360+2019T1","course-v1:ZAFU+20171218+2019T1","course-v1:BNU+0910042801+2019T1","course-v1:AA+FA2X+2019T1","course-v1:AA+FA2Xen+2019T1","course-v1:BNU+2018011801X+2019T1","course-v1:BNU+0610073981+2019T1","course-v1:BNU+1010070372+2019T1","course-v1:BNU+GE310141091+2019T1","course-v1:AA+MA2Xen+2019T1","course-v1:AA+FA1X+2019T1","course-v1:AA+MA1Xen+2019T1","course-v1:BNU+PHI2107404101+2019T1","course-v1:BNU+2017001+2019T1","course-v1:BNU+0610073991+2019T1","course-v1:TsinghuaX+80511503X+2019T1","course-v1:AA+FA1Xen+2019T1","course-v1:SichuanU+106588020+sp","course-v1:BurgundyX+82005+2019T1","course-v1:HRBEU+2018081301+sp","course-v1:GZHU+136300904+2019T1","course-v1:XJTU+20171025001+2019T1","course-v1:TsinghuaX+20740084X+2019T1","course-v1:FAFU+55071003+2019T1","course-v1:TsinghuaX+80000522X+2019T1","course-v1:TsinghuaX+40040152X+2019T1","course-v1:TsinghuaX+40130653X+2019T1","course-v1:TsinghuaX+20240103X+2019T1","course-v1:TsinghuaX+THU201606X+2019T1","course-v1:TsinghuaX+30260032X+2019T1","course-v1:TsinghuaX+60250101X+2019T1","course-v1:TsinghuaX+THU201602+2019T1","course-v1:TsinghuaX+40260173X+2019T1","course-v1:xuetangX+MOO102+2019T1","course-v1:TsinghuaX+00510888X+2019T1","course-v1:HEBUT+20180207002+2019T1","course-v1:MITx+15390x1+2019T1","course-v1:TsinghuaX+60610231p1+2019T1","course-v1:TsinghuaX+THU00001X+2019T1","course-v1:XAAU+20180411001+2019T1","course-v1:TsinghuaX+80590952X+2019T1","course-v1:TsinghuaX+20120143X+2019T1","course-v1:TsinghuaX+10610193X+2019T1","course-v1:TsinghuaX+106101832X+2019T1","course-v1:TsinghuaX+10620204X+2019T1","course-v1:TsinghuaX+00690092X+2019T1","course-v1:SUT+SM001+2019T1","course-v1:TsinghuaX+44100343X+2019T1","course-v1:TsinghuaX+10610224X+2019T1","course-v1:TsinghuaX+30640014X+2019T1","course-v1:TsinghuaX+90640012X1+2019T1","course-v1:TsinghuaX+90640012X+2019T1","course-v1:LUIBE+2018030701+2019T1","course-v1:TsinghuaX+01030132X+2019T1","course-v1:TsinghuaX+80160283+2019T1","course-v1:HEBNU+20180621001+2019T1","course-v1:TsinghuaX+02070251X+2019T1","course-v1:TsinghuaX+80590982X+2019T1","course-v1:QU+2017121401X+2019T1","course-v1:TsinghuaX+00690342X+2019T1","course-v1:BFU+15012510+2019T1","course-v1:BFU+15023710+2019T1","course-v1:TsinghuaX+TSINGHUA107+2019T1","course-v1:TsinghuaX+80000271X+2019T1","course-v1:TsinghuaX+006903022+2019T1","course-v1:TsinghuaX+Grasshopper101+2019T1","course-v1:TsinghuaX+20320074X+2019T1","course-v1:TsinghuaX+34000312X+2019T1","course-v1:SU+20180920X+2019T1","course-v1:XYSFXY+20181024X+2019T1","course-v1:PPSU+2017052301+2019T1","course-v1:ZUEL+20181108X+2019T1","course-v1:TsinghuaX+70800232X+2019T1","course-v1:TsinghuaX+70240183x1+2019T1","course-v1:NBx+NB000502+2019T1","course-v1:ZUELX+B0601353+2019T1","course-v1:TsinghuaX+80611322X+2019T1","course-v1:QU+MATH20041X+2019T1","course-v1:TsinghuaX+64100033X+2019T1","course-v1:U+119511+2019T1","course-v1:TsinghuaX+80150193X+2019T1","course-v1:SEU+00690803+2019T1","course-v1:TsinghuaX+30700313X+2019T1","course-v1:TsinghuaX+80000822X+2019T1","course-v1:TsinghuaX+80000901X1+2019T1","course-v1:UPB+100722004+2019T1","course-v1:HUST+0200421+2019T1","course-v1:TsinghuaX+80000901X2+2019T1","course-v1:TsinghuaX+10430575X+2019T1","course-v1:FUDANx+EON130088+2019T1","course-v1:FUDANx+EON13000701+2019T1","course-v1:FUDANx+EON1300812+2019T1","course-v1:FUDANx+EON130080+2019T1","course-v1:FUDANx+SOS120007+2019T1","course-v1:ZZU+334068+2019T1","course-v1:UPB+100203E003+2019T1","course-v1:UPB+UPB201702+2019T1","course-v1:JNUX+jnu2017001X+2019T1","course-v1:KMUSTX+8209001+2019T1","course-v1:TsinghuaX+30040263X+sp","course-v1:JNU+07009215+2019T1","course-v1:JXUST+JXUST2016001+2019T1","course-v1:JNU+11022048+2019T1","course-v1:JNU+03010015+2019T1","course-v1:JNU+11020009+2019T1","course-v1:TsinghuaX+30590023+2019T1","course-v1:HQU+20180307002+2019T1","course-v1:UST+AP000011X+2019T1","course-v1:TsinghuaX+20180131001+2019T1","course-v1:GZHU+000001004+2019T1","course-v1:TsinghuaX+40250074X+2019T1","course-v1:TsinghuaX+40250683X+2019T1","course-v1:HUBU+20190124X+2019T1","course-v1:TsinghuaX+AP000015X+2019T1","course-v1:TsinghuaX+AP000001X+2019T1","course-v1:TsinghuaX+AP201601X+2019T1","course-v1:TsinghuaX+AP000002X+2019T1","course-v1:TsinghuaX+AP000005X+2019T1","course-v1:RUX+AP000010X+2019T1","course-v1:TsinghuaX+AP000016X+2019T1","course-v1:TsinghuaX+104500341X2X+2019T1","course-v1:TsinghuaX+AP000003X+2019T1","course-v1:TsinghuaX+AP000014X+2019T1","course-v1:TsinghuaX+AP000013X+2019T1","course-v1:TsinghuaX+AP000008X+2019T1","course-v1:TsinghuaX+AP000004X+2019T1","course-v1:SU+20180919X+2019T1","course-v1:TsinghuaX+80030222X+2019T1","course-v1:SUE+20171229001+2019T1","course-v1:TsinghuaX+70240403+2019T1","course-v1:IMUN+5024610+2019T1","course-v1:TsinghuaX+8070071301+2019T1","course-v1:TsinghuaX+8070071302+2019T1","course-v1:TsinghuaX+20180412+2019T1","course-v1:SUT+2019012401X+SP","course-v1:GZUM+2019012801X+2019T1","course-v1:dlmu+20180906+2019T1","course-v1:ZUEL+2019012806X+2019T1","course-v1:TsinghuaX+80512073X+2019T1","course-v1:TsinghuaX+JRFX01+2019T1","course-v1:HEBUT+20180208006+2019T1","course-v1:HNU+20180706002+2019T1","course-v1:SU+25071011201+2019T1","course-v1:KMUSTX+8219011+2019T1","course-v1:BIT+100070018+2019T1","course-v1:BIT+100070018+2019T2","course-v1:rcoe+mooc103+2019T1","course-v1:MIL+MIL2016001+2019T1","course-v1:TsinghuaX+40160092X+2019T1","course-v1:TsinghuaX+TsinghuaX+2019T1","course-v1:TsinghuaX+00990021X+2019T1","course-v1:GIT+0500002402+2019T1","course-v1:FZXY+20180301001+2019T1","course-v1:SU+2018020201X+2019T1","course-v1:SEU+006908032+2019T1","course-v1:JNUX+07009156X+2019T1","course-v1:TsinghuaX+10421075X+2019T1","course-v1:TsinghuaX+60510102X+2019T1","course-v1:TsinghuaX+10421084X+2019T1","course-v1:TsinghuaX+60610231+2019T1","course-v1:BNU+2017053101X+2019T1","course-v1:BJTU+2017052601X+2019T1","course-v1:TsinghuaX+30803273X+2019T1","course-v1:TsinghuaX+40670702X+2019T1","course-v1:FAFU+20180919X+2019T1","course-v1:TsinghuaX+20740042X+2019T1","course-v1:TsinghuaX+20440333X+2019T1","course-v1:FJTM+20180622001+2019T1","course-v1:GZHU+20180718001+2019T1","course-v1:SichuanU+302074030+2019T1","course-v1:DYU+dyuwgzbbm+2019T1","course-v1:NTU+wym+2019T1","course-v1:BNU+ENV13018+2019T1","course-v1:BNU+2018122405X+2019T1","course-v1:BNU+2017071001X+2019T1","course-v1:TsinghuaX+40130753+2019T1","course-v1:BNU+2018122601X+2019T1","course-v1:U+2018081702X+2019T1","course-v1:BNU+HE21128011+2019T1","course-v1:MITx+15671x+2019T1","course-v1:TsinghuaX+00680142X+2019T1","course-v1:MITx+156711X+2019T1","course-v1:UBerkeleyX+olWri21x2015T1+2019T1","course-v1:XJTU+HEM330109+2019T1","course-v1:BNU+0210021441+2019T1","course-v1:NTU+lhtl+2019T1","course-v1:TsinghuaX+2018031601X+2019T1","course-v1:TsinghuaX+20190222+2019T1","course-v1:TsinghuaX+THU201607+2019T1","course-v1:TsinghuaX+70340063X+2019T1","course-v1:XJTU+00204+2019T1","course-v1:HUBU+HU08001X+2019T1","course-v1:SichuanU+306197030+2019T1","course-v1:SUT+145223+2019T1","course-v1:TsinghuaX+40990255+2019T1","course-v1:HUBU+20181017X+2019T1","course-v1:TsinghuaX+20190225x+2019T1","course-v1:ZUELX+20171127001+2019T1","course-v1:JNUX+jnu05011190X+2019T1","course-v1:TsinghuaX+THUSEM002+2019T1","course-v1:NBx+NB000002+2019T1","course-v1:TsinghuaX+40150442+2019T1","course-v1:imvtc+2018122701+2019T1","course-v1:SUT+20180427001+2019T1","course-v1:GZLIS+070200140+2019T1","course-v1:TsinghuaX+40670453X+2019T1","course-v1:JNU+20180722001+2019T1","course-v1:TsinghuaX+L061101X+sp","course-v1:TsinghuaX+61030031X+2019sp","course-v1:TsinghuaX+30230931X+2019T1","course-v1:TsinghuaX+30130274X+2019T1","course-v1:HQU+20180307006+2019T1","course-v1:YAU+20181108X+2019T1","course-v1:ZJFF+000516+2019T1","course-v1:BSU+2018122403X+2019T1","course-v1:KMUSTX+1803168+2019T1","course-v1:YSU+20180301001+2019T1","course-v1:HQU+20180307008+2019T1","course-v1:SUE+20180620001+2019T1","course-v1:TsinghuaX+10450012X+2019T1","course-v1:XMU+2019031401X+2019T1","course-v1:SWU+2019031403X+2019T1","course-v1:BIFT+1301990078+2019T1","course-v1:PekingX+2018122102X+2019T1","course-v1:PekingX+2018122101X+2019T1","course-v1:chzu+ZJ1867357+2019T1","course-v1:qhnu+20181212x+2019T1","course-v1:gztrc+2018122601+2019T1","course-v1:BUM+2018122604X+2019T1","course-v1:TsinghuaX+2019032101X+2019T2","course-v1:shsmu+shsmu001+2019T1","course-v1:imvtc+2018122702+2019T1","course-v1:GDUT+2018120405X+2019T1","course-v1:NGO20X+UST2016002+2019T1","course-v1:BNU+2018122602X+2019T1","course-v1:TsinghuaX+04000083+2019T1","course-v1:btbu+20181228+2019T1","course-v1:BSU+2018122405X+2019T1","course-v1:HEBUT+2019040202X+2019T1","course-v1:UST+SE20190403X+sp","course-v1:QLU+2018122607X+2019T1","course-v1:BFU+2018122709+2019T1","course-v1:NEU+2018122401X+2019T1","course-v1:SUE+2018112001X+2019T1","course-v1:XJTU+2018112004X+2019T1","course-v1:TsinghuaX+34100333+2019T1","course-v1:MU+2018122401X+2019T1","course-v1:DUT+3412113011+2019T1","course-v1:nxu+2018122712+2019T1","course-v1:BSU+2018122404X+2019T1","course-v1:nxu+2018122711+2019T1","course-v1:BFU+2018122710+2019T1","course-v1:nxu+2018122713+2019T1","course-v1:jxust+2018122701X+2019T1","course-v1:TsinghuaX+30240332+2019T1","course-v1:TJUFE+2018122506X+2019T1","course-v1:TsinghuaX+20180919X+2019T1","course-v1:NDU+2019042601X+2019T2","course-v1:SU+2019043001X+2019T1","course-v1:SMZXY+2018111301X+2019T2","course-v1:SYJU+030020406+2019T1","course-v1:HBNU+2019051509X+2019T1","course-v1:TIS+2019032101X+2019T2","course-v1:TIS+2019032501X+2019T2","course-v1:TIS+2019032502X+2019T2","course-v1:SU+82150112201+2019T2","course-v1:TW+2018052501X+2019T3","course-v1:TsinghuaX+60700052X+2019T2","course-v1:TsinghuaX+80515182X+2019sp","course-v1:NEU+2019012201X+2019T2","course-v1:NEU+2019012202X+2019T2");
