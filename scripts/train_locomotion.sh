feature_dim=50
sgqn_quantile=0.93
action_repeat=2
aux_lr=8e-5

# need change
frames=1001000
task_name=walker_walk
env=dmc
algorithm=pieg_cycaug
device_id_list=(0 1 2 3 4)

for ((i=1;i<=5;i+=1))
do
	seed=$((i))
	log_folder="./output/train/${env}/${task_name}/${algorithm}/${seed}"
	if [ ! -d "$log_folder" ]; then
		mkdir -p "$log_folder"
		echo "已创建 $log_folder 文件夹"
	else
		echo "$log_folder 文件夹已存在"
	fi
	# echo "GPU=${device_id}" > "${log_folder}/${i}_env_$(date +"%Y-%m-%d %H:%M:%S").log"
	device_id=${device_id_list[i-1]}
	echo ${device_id}
	CUDA_VISIBLE_DEVICES=${device_id} nohup python train.py \
								env=${env} \
								task=${task_name} \
								seed=${seed} \
								action_repeat=${action_repeat} \
								use_wandb=False \
								use_tb=False \
								num_train_frames=${frames} \
								save_snapshot=True \
								save_video=False \
								feature_dim=${feature_dim} \
								> "${log_folder}/${seed}_$(date +"%Y-%m-%d %H:%M:%S").log" 2>&1 &
done