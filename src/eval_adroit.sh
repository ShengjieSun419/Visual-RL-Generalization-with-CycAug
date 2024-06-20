
save_snapshot=False
use_wandb=False
stage1_use_pretrain=False

stage2_n_update=0
save_models=False

# need change
task_name='pen'
num_train_frames=2001000
algorithm=pieg_cycaug
algorithm_for_cyc=pieg+cycaug
device_id_list=(7 1 2 1 1)
wandb_group=("test_${algorithm_for_cyc}_color-hard" "test_${algorithm_for_cyc}_video-hard")


for ((i=1;i<=1;i+=1))
do
	seed=${i}
	# using stable model
	prefix_path="./output_stable/train/adroit/${task_name}-v0/${algorithm}/${seed}"
	eval_path="./output_stable/eval/adroit/${task_name}-v0/${algorithm}/${seed}"
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
	for ((j=0; j<${#wandb_group[@]}; j++)); do
    	echo "${wandb_group[j]}"

		current_time=$(date +"%Y-%m-%d %H:%M:%S")
		CUDA_VISIBLE_DEVICES=${device_id} python eval_adroit.py \
				task=${task_name} \
				seed=${seed} \
				stage1_use_pretrain=${stage1_use_pretrain} \
				save_snapshot=${save_snapshot} \
				device=cuda:0 \
				use_wandb=${use_wandb} \
				stage2_n_update=${stage2_n_update} \
				num_train_frames=${num_train_frames} \
				save_models=${save_models} \
				model_dir=${model_dir} \
				wandb_group=${wandb_group[j]} \
				save_video=True \
				> "${eval_path}/eval_${seed}_${wandb_group[j]}_$(date +"%Y-%m-%d %H:%M:%S").log" 2>&1 &
	done
done
