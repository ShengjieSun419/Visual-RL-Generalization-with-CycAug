
save_snapshot=False
use_wandb=False
stage1_use_pretrain=False

stage2_n_update=0
save_models=True
local_data_dir=/data/your_path/VRL3-open-source/vrl3data

# need change
task_name='door'
num_train_frames=1001000
algorithm=pieg_cycaug
device_id_list=(2 4 5 6 7)

for ((i=1;i<=5;i+=1))
do
	seed=$((i))
	log_folder="./output/train/adroit/${task_name}-v0/${algorithm}/${seed}"
	if [ ! -d "$log_folder" ]; then
		mkdir -p "$log_folder"
		echo "已创建 $log_folder 文件夹"
	else
		echo "$log_folder 文件夹已存在"
	fi
	# echo "GPU=${device_id}" > "${log_folder}/${i}_env_$(date +"%Y-%m-%d %H:%M:%S").log"
	device_id=${device_id_list[i-1]}
	echo ${device_id}
	CUDA_VISIBLE_DEVICES=${device_id} nohup python train_adroit_dhm.py \
								task=${task_name} \
								seed=${seed} \
								stage1_use_pretrain=${stage1_use_pretrain} \
								save_snapshot=${save_snapshot} \
								device=cuda:0 \
								local_data_dir=${local_data_dir} \
								use_wandb=${use_wandb} \
								stage2_n_update=${stage2_n_update} \
								num_train_frames=${num_train_frames} \
								save_models=${save_models} \
								wandb_group=$2 \
								> "${log_folder}/${seed}_$(date +"%Y-%m-%d %H:%M:%S").log" 2>&1 &
done