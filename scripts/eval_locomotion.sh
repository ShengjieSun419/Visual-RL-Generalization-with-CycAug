type_list=("original" "color" "video" "original")
difficulty_list=("easy" "hard" "hard" "easy")
intensity_list=(0 0 0 0.2)
is_distracting_cs_list=("False" "False" "False" "True")

# need change
domain_name=walker
task_name=walk
algorithm=pieg_cycaug
device_id_list=(3 4 5 6 7)

for ((i=1;i<=5;i+=1))
do
	seed=${i}
	# using stable model
	prefix_path="output/train/dmc/${domain_name}_${task_name}/${algorithm}/${seed}"
	eval_path="output/eval/dmc/${domain_name}_${task_name}/${algorithm}/${seed}"
	if [ ! -d "$eval_path" ]; then
		# 如果路径不存在，则创建路径
		mkdir -p "$eval_path"
		echo "已创建 $eval_path 文件夹"
	else
		echo "$eval_path 文件夹已存在"
	fi

	model_dir=$(ls -d "$prefix_path"/*/ | sort -Vr | head -n 1)
	echo "${model_dir}"
	device_id=${device_id_list[i-1]}
	echo ${device_id}
	for ((j=0; j<${#type_list[@]}; j++)); do
    	echo "${type_list[j]} - ${difficulty_list[j]} - ${intensity_list[j]}"

		current_time=$(date +"%Y-%m-%d %H:%M:%S")
		CUDA_VISIBLE_DEVICES=${device_id} python3 locoeval.py \
				--algorithm ${algorithm} \
				--eval_episodes 100 \
				--seed ${seed} \
				--domain_name ${domain_name} \
				--task_name ${task_name} \
				--model_dir ${model_dir} \
				--type ${type_list[j]} \
				--difficulty ${difficulty_list[j]} \
				--intensity ${intensity_list[j]} \
				--is_distracting_cs ${is_distracting_cs_list[j]} \
				--save_video \
				> "${eval_path}/eval_${seed}_${current_time}_${type_list[j]}_${difficulty_list[j]}_${intensity_list[j]}.log" 2>&1 &
	done
done

