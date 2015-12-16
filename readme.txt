《汽轮机课程设计指导书》配套光盘程序使用说明
感谢读者使用《汽轮机课程设计指导书》配套光盘程序！
《汽轮机课程设计指导书》配套光盘中程序组为Matlab源代码程序，该程序在Matlab R2006a上运行通过，为了方便读者使用，现说明如下：
该程序分为两个部分：（1）水和水蒸汽性质子程序组；（2）汽轮机热力计算程序组。
1、水蒸汽性质子程序组
该程序组共包含10个子程序，全部为计算水和水蒸汽性质的子程序，采用的是国际公式化委员会制定的水和水蒸气热力性质（IFC67）公式。各子程序分别是：
TSK.m     求某下压力饱和温度。
PSK.m     某温度下饱和压力。
HS.m      已知比焓、比熵，求其它性质。
PX.m      已知压力、干度，求其它性质。
PV.m      已知压力、比熵，求其它性质。
PTG.m     已知压力、温度，求饱和汽、过热蒸汽的性质。
PTF.m     已知压力、温度，求饱和水、过冷水的性质。
PT.m      已知压力、温度，求其它性质。
PS.m      已知压力、比熵，求其它性质。
PH.m      已知压力、比焓，求其它性质。

这些程序参数的单位及具体应用范围见程序代码里面的说明，并且该子程序组只适合亚临界情况下的水和水蒸汽性质计算。

2、汽轮机热力计算程序组
该程序组共包含21个子程序，全部汽轮机热力设计中应用的子程序，该子程序组分为两类，一类是输入参数用，程序名以Known_开头；一类是通用计算程序，与具体参数无关，使用时与对应Known_类程序配合使用。各子程序分别是：
Known_graph_parameters.m     拟定热力过程线所需参数。
Thermal_graph.m     热力过程线初步拟定。
Known_SteamWater_parameters.m      计算汽水参数所需参数（初次）。
SteamWater_parameters.m      计算汽水参数（初次）。
Known_lossflow_parameters.m      计算门杆轴封漏汽量所需参数。
Turbine_lossflow.m     计算门杆轴封漏汽。
Known_stage_parameters.m     级详细计算所需参数。
Turbine_stage.m      级详细计算。
Known_stagedistribute_parameters.m     分级计算所需参数。
Turbine_stagedistribute.m              分级计算。
Known_SteamWater_parameters_re.m      重新计算汽水参数。
SteamWater_parameters_rebuild.m      重新计算汽水参数。
Heater_extractionflow.m              计算回热抽汽量。
Known_Result_Check.m              流量功率校核及指标计算所需数据。
Result_Check.m                     流量功率校核及指标计算。	
Known_stageloss_parameters.m        级内损失详细计算所需系数。
Getsumdeltah.m                     计算级内损失通用计算程序（轮周损失之外）。
Known_stage_backward.m               级变工况倒序计算所需参数。
Varying_stage_BackwardCal.m            压力级变工况倒序核算子程序。
Known_stage_sequence.m                级变工况顺序计算所需参数。
Varying_stage_SequenceCal.m            压力级变工况顺序核算子程序。

这些程序参数的单位及具体应用范围见程序代码里面的说明，热力过程线及分级图结果以图片的形式保存在程序目录（.fig格式，需用matlab打开），其它计算结果以Excel的形式保存在程序目录（Design_results.xls）。
使用这些程序时，请设置两个程序组的文件夹(IFC67和Turbine_Design)为malab工作文件夹，请勿改变Design_results.xls的位置。

以上程序均为开放代码，只用于教育与科学研究，不得用于商业行为。欢迎读者进行代码优化，基于对作者的尊重，希望您在转载、二次开发及发表使用该程序得到的成果时，请标注引用源。
再一次感谢各位读者的使用，若有不明之处，请与作者联系，zrqwl2003@126.com。
