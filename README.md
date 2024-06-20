

# Enhancing Visual Generalization in Reinforcement Learning with Cycling Augmentation

This repository is an implementation of the paper, "Enhancing Visual Generalization in Reinforcement Learning with Cycling Augmentation". Our code is based on [RL-ViGen](https://github.com/gemcollector/RL-ViGen). We combine various algorithms with Cycling Augmentation (CycAug) and evaluate them in different generalization environments on Locomotion and Dexterous Manipulation.

## Intallation
To install the benchmark, please follow the instructions in [INSTALLATION.md](INSTALLATION.md).

## Code Structure
- `algos`: contains the implementation of different algorithms.
- `cfgs`: contains the hyper-parameters for different algorithms and each tasks.
- `envs`: various RL-ViGen benchmark environments. In addtion, each sub-folder contains specific `README.md` for the introduction of the environment.
- `setup`: the installation scripts for conda envs.
- `third_party`: submodules from third parties. We won't frequently change the code in this folder.
- `wrappers`: includes the wrappers for each environment.
- `scripts`: includes scripts that facilitate training and evaluation. 


## Extra Datasets
The algorithms will use the [Places](http://places2.csail.mit.edu/download.html) dataset for data augmentation, which can be downloaded by running
```
wget http://data.csail.mit.edu/places/places365/places365standard_easyformat.tar
```
After downloading and extracting the data, add your dataset directory to the datasets list in `cfgs/aug_config.cfg`.

## Training

### Habitat, Robosuite, Locomotion
```
cd RL-ViGen/
bash scripts/train.sh
```
### CARLA
```
cd RL-ViGen/
bash scripts/carlatrain.sh
```

## Evaluation
For evaluation, you should change `model_dir` to your own saved model folder first. Regarding  `Robosuite` , `Habitat`, and `CARLA`, we can run the evaluation code as follow:
```
cd RL-ViGen/
bash scripts/eval.sh 
```
You should change the `env`, `task_name`, `test_agent` for different evaluation in the `eval.sh`.

For `DM-Control`, we can run the evaluation code as follow:
```
cd RL-ViGen/
bash scripts/locoeval.sh
```

For more details, please refer to the `README.md` files for each environment in the `env/` directory.


all the Adroit configureation is on the branch `ViGen-adroit`.

## License
The majority of DrQ-v2, DMCGB, VRL3 is licensed under the MIT license. Habitat Lab, dmc2gym, mujoco-py are also licensed under the MIT license. However portions of the project are available under separate license terms: DeepMind,  mj_envs, and mjrl is licensed under the Apache 2.0 license. Gibson based task datasets, the code for generating such datasets, and trained models are distributed with [Gibson Terms of Use](https://storage.googleapis.com/gibson_material/Agreement%20GDS%2006-04-18.pdf) and under [CC BY-NC-SA 3.0 US license](https://creativecommons.org/licenses/by-nc-sa/3.0/us/). CARLA specific assets are distributed under CC-BY License. The ad-rss-lib library compiled and linked by the [RSS Integration build variant](Docs/adv_rss.md) introduces [LGPL-2.1-only License](https://opensource.org/licenses/LGPL-2.1). Unreal Engine 4 follows its [own license terms](https://www.unrealengine.com/en-US/faq).
