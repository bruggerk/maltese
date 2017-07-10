#python  ./bin/maltese -v -a /media/lahat/HellasPlanitia/annotations/mouse /media/lahat/HellasPlanitia/lahat.albert@gmail.com/Work/Projects/NclMainStudyMice_AnalysisSep_2015/splicing/rMATS/AL15_vs_AL24/MATS_output/SE.MATS.ReadsOnTargetAndJunctionCounts.txt0.001.csv -s '\t' -F '1,3,5,6,4,18,23' 
cores=6
echo > .done.tmp
echo > .doing.tmp
for event in SE RI; do
	for i in /media/lahat/HellasPlanitia/lahat.albert@gmail.com/Work/Projects/NclMainStudyMice_AnalysisSep_2015/splicing/rMATS/*/MATS_output/${event}.MATS.ReadsOnTargetAndJunctionCounts.txt0.001.csv; do
		while true; do
			if [ $( expr $( wc -l .doing.tmp  | cut -f1 -d ' ' ) - $( wc -l .done.tmp  | cut -f1 -d ' ' ) ) -lt "$cores" ]; then
				break
			fi
		done
		$( echo $i >> .doing.tmp ; \
		python  ./bin/maltese \
			-v \
			-a /media/lahat/HellasPlanitia/annotations/mouse \
			$i \
			-s '\t' \
			-F '2,3,5,6,4,18,23' ; \
		echo $i >> .done.tmp ) &
		expr $( wc -l .doing.tmp  | cut -f1 -d ' ' ) - $( wc -l .done.tmp  | cut -f1 -d ' ' )
	done
done

