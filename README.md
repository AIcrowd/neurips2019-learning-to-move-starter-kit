![CrowdAI-Logo](https://github.com/crowdAI/crowdai/raw/master/app/assets/images/misc/crowdai-logo-smile.svg?sanitize=true)
# NIPS 2018 : AI for Prosthetics Challenge Round2 Starter Kit
[![gitter-badge](https://badges.gitter.im/crowdAI/NIPS-Learning-To-Run-Challenge.png)](https://gitter.im/crowdAI/NIPS-Learning-To-Run-Challenge)   

Instructions to make submissions to the final round of the [NIPS 2018 : AI for  Prosthetics Challenge](https://www.crowdai.org/challenges/nips-2018-ai-for-prosthetics-challenge).

Participants will have to submit their code, with packaging specifications, and the evaluator will automatically build a docker image and execute their agent against the `ProstheticsEnv` with `difficulty=2` and a series of random seeds for 10 episodes.

### Setup
* **docker** : By following the instructions [here](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
* **nvidia-docker** : By following the instructions [here](https://github.com/nvidia/nvidia-docker/wiki/Installation-(version-2.0))
* **crowdai-repo2docker**
```sh
pip install crowdai-repo2docker
```
* **Anaconda** (By following instructions [here](https://www.anaconda.com/download)) 
* **osim-rl** (By following instructions [here](http://github.com/stanfordnmbl/osim-rl/))
**IMPORTANT** : Please note that you will need `osim-rl` version `>=2.1.3` to be able to submit which you can update in your anaconda env by :
```
pip install -U osim-rl
```
* **Your code specific dependencies**
```sh
# If say you want to install PyTorch
conda install pytorch torchvision -c pytorch
```

### Clone repository 
```
git clone git@github.com:crowdAI/nips2018-ai-for-prosthetics-round2-starter-kit.git
cd nips2018-ai-for-prosthetics-round2-starter-kit
```

### Test Submission Locally
```
cd nips2018-ai-for-prosthetics-round2-starter-kit
export IMAGE_NAME="ai-for-prosthetics-agent"

# Build docker image for your submission
./build.sh

# In a separate tab : run redis server 
./run_redis.sh 

# In a separate tab : run local grader 
./run_local_grader.sh

# In a separate tab :
# Finally, run your agent locally by :
./debug.sh
```

# Author 
Sharada Mohanty <https://twitter.com/MeMohanty>
