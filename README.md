![AIcrowd-Logo](https://raw.githubusercontent.com/AIcrowd/AIcrowd/master/app/assets/images/misc/aicrowd-horizontal.png)

# NeurIPS 2019: Learning to Move - Walk Around Starter Kit

[![gitter-badge](https://badges.gitter.im/crowdAI/NIPS-Learning-To-Run-Challenge.png)](https://gitter.im/crowdAI/NIPS-Learning-To-Run-Challenge)

###

In the [NeurIPS 2019: Learning to Move - Walk Around Challenge](https://www.aicrowd.com/challenges/neurips-2019-learning-to-move-walk-around) we ask you to submit the code of the controller you built. The grader server will build a docker container from your repository, run it and evaluate it on `L2M2019Env` environment with `difficulty=2` and a series of random seeds for **N** episodes.

First, we show how to submit the most basic controller. Next, we explain how to add your own controller. Finally, we present how to debug your submission by running the docker locally.

### Getting started

In order to get acquainted with our system, we recommend you first submit a test controller (random actions).
Follow these simple steps:
1. Sign-up to AICrowd here https://www.aicrowd.com/participants/sign_in (use github or sign up at the bottom). Let’s say your username is `aicrowd-username`
2. Create a private repository at https://gitlab.aicrowd.com/. Let's call it `neurips2019-learn-to-move`
3. Create an SSH key on your local machine and add it to crowdAI gitlab as described here https://docs.gitlab.com/ee/ssh/README.html#generating-a-new-ssh-key-pair
4. Run the following bash commands (replace **[aicrowd-username]** with your actual username):
```sh
git clone https://github.com/AIcrowd/neurips2019-learning-to-move-starter-kit.git neurips2019-learn-to-move
cd neurips2019-learn-to-move
git remote add aicrowd git@gitlab.aicrowd.com:[aicrowd-username]/neurips2019-learn-to-move.git
git tag -am "submission-v0.1" submission-v0.1
git push aicrowd master
git push aicrowd submission-v0.1
```

The code above will:
1. Clone the submission repository repository
2. Add your private gitlab.aicrowd.com repository as a remote
3. Tag the repository with `submission-X` where `X` can be anything
4. Push the repository and the tag

Each tagged commit is treated as a submission and evaluated by the grader.

The actual controller you are submitting is in the `run.py` file — this file is executed by the grader. You can simply replace the random controller [here](https://github.com/AIcrowd/neurips2019-learning-to-move-starter-kit/blob/master/run.py#L48)
with your controller (a function from states to actions).

The grader will create a docker environment with your solution and you are free to use any library available on ubuntu.

You will find more details below.

### Creating the controller

For creating your controller follow the steps [here](https://github.com/stanfordnmbl/osim-rl/blob/master/README.md) and the materials [here](http://osim-rl.stanford.edu/). In this repository, we only describe how to submit an already existing controller to the grader. In particular, we assume that:
* You've already set up a conda environment (say `opensim-rl` as in [the tutorial](https://github.com/stanfordnmbl/osim-rl/blob/master/README.md))
* You've already built some controller and you have it in your code somewhere as `my_controller` function.

To submit your controller, you will simply need to:
* Go to `neurips2019-learn-to-move` directory that you created above
* Export your conda environment 
```
source activate opensim-rl
conda env export --no-build > environment.yml
```
* Copy your code to `neurips2019-learn-to-move` and integrate your `my_controller` function into the [run.py](https://github.com/AIcrowd/neurips2019-learning-to-move-starter-kit/blob/master/run.py#L48) script.

The `environment.yml` file will be used to recreate the `conda environment` inside the Docker container in the grader on the server. This repository includes an example `environment.yml`.

### Specific code dependecies

In your conda environment you can install anything you need simply by runnyng `conda install` or `pip install`. For example, you can install pytorch
```sh
conda install pytorch torchvision -c pytorch
```
or opencv
```sh
pip install opencv-python
```

# More details on how should you structure your code

Please follow the structure documented in the included [run.py](https://github.com/AIcrowd/neurips2019-learning-to-move-starter-kit/blob/master/run.py) to adapt
your already existing code to the required structure for this round.

## Important Concepts

### Repository Structure

- `aicrowd.json`
  Each repository should have a `aicrowd.json` with the following content:

```json
{
  "challenge_id": "learning_to_walk_2019",
  "grader_id": "learning_to_walk_2019",
  "authors": ["your-aicrowd-username"],
  "description": "sample description about your awesome agent",
  "license": "MIT",
  "gpu": false,
  "debug" : false  
}
```

This is used to map your submission to the said challenge, so please remember to use the correct `challenge_id` and `grader_id` as specified above.

Please specify if your code will a GPU or not for the evaluation of your model. If you specify `true` for the GPU, a **NVIDIA Tesla K80 GPU** will be provided and used for the evaluation.

If you set `debug` to `true`, then the evaluation will run on a separate set of 3 seeds, and the logs from your submitted code (if it fails), will be made available to you to help you debug.

### Packaging of your software environment

You can specify your software environment by using all the [available configuration options of repo2docker](https://repo2docker.readthedocs.io/en/latest/config_files.html). (But please remember to use [aicrowd-repo2docker](https://pypi.org/project/aicrowd-repo2docker/) to have GPU support)

The recommended way is to use Anaconda configuration files using **environment.yml** files.

```sh
# The included environment.yml is generated by the command below, and you do not need to run it again
# if you did not add any custom dependencies

conda env export --no-build > environment.yml

# Note the `--no-build` flag, which is important if you want your anaconda env to be replicable across all
```

### Debugging the packaged software environment

If you have issues with your submission because of your software environment and dependencies, you can debug them, by first building the docker image, and then getting a shell inside the image by:

```
nvidia-docker run --net=host -it $IMAGE_NAME /bin/bash
```

and then exploring to find the cause of the issue.

### Code Entrypoint

The evaluator will use `/home/aicrowd/run.sh` as the entrypoint, so please remember to have a `run.sh` at the root, which can instantitate any necessary environment variables, and also start executing your actual code. This repository includes a sample `run.sh` file.
If you are using a Dockerfile to specify your software environment, please remember to create a `aicrowd` user, and place the entrypoint code at `run.sh`.

## Submission

To make a submission, you will have to create a private repository on [https://gitlab.aicrowd.com/](https://gitlab.aicrowd.com/).

You will have to add your SSH Keys to your GitLab account by following the instructions [here](https://docs.gitlab.com/ee/gitlab-basics/create-your-ssh-keys.html).
If you do not have SSH Keys, you will first need to [generate one](https://docs.gitlab.com/ee/ssh/README.html#generating-a-new-ssh-key-pair).

Then you can create a submission by making a _tag push_ to your repository on [https://gitlab.aicrowd.com/](https://gitlab.aicrowd.com/).
**Any tag push (where the tag name begins with "submission-") to your private repository is considered as a submission**  
Then you can add the correct git remote, and finally submit by doing:

```
cd neurips2019-learning-to-move-starter-kit
# Add AIcrowd git remote endpoint
git remote add aicrowd git@gitlab.aicrowd.com/:<YOUR_AICROWD_USER_NAME>/neurips2019-learning-to-move-starter-kit.git
git push aicrowd master

# Create a tag for your submission and push
git tag -am "submission-v0.1" submission-v0.1
git push aicrowd master
git push aicrowd submission-v0.1

# Note : If the contents of your repository (latest commit hash) does not change,
# then pushing a new tag will **not** trigger a new evaluation.
```

You now should be able to see the details of your submission at:
[gitlab.aicrowd.com//<YOUR_AICROWD_USER_NAME>/neurips2019-learning-to-move-starter-kit/issues](gitlab.aicrowd.com//<YOUR_AICROWD_USER_NAME>/neurips2019-learning-to-move-starter-kit/issues)

**NOTE**: Remember to update your username in the link above :wink:

In the link above, you should start seeing something like this take shape (each of the steps can take a bit of time, so please be patient too :wink: ) :
![](https://i.imgur.com/Kc7M8zH.png)

and if everything works out correctly, then you should be able to see the final scores like this:
![](https://i.imgur.com/9RT2jFi.png)

**Best of Luck** :tada: :tada:

### Debugging setup

For debugging the submission locally, you will need

- **docker** : By following the instructions [here](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
- **nvidia-docker** : By following the instructions [here](<https://github.com/nvidia/nvidia-docker/wiki/Installation-(version-2.0)>)
- **aicrowd-repo2docker**

```sh
pip install aicrowd-repo2docker
```

### Test Submission Locally

You can reproduce our grader environment on your local machine running the following scripts

```
cd neurips2019-learn-to-move
export IMAGE_NAME="learning-to-move-agent"

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

Seungmoon Song <https://github.com/smsong>

Łukasz Kidziński <https://twitter.com/kidzik>
