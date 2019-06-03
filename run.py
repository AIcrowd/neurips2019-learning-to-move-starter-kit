#!/usr/bin/env python

import opensim as osim

from osim.redis.client import Client
from osim.env import *
import numpy as np
import argparse
import os

"""
NOTE: For testing your submission scripts, you first need to ensure 
that redis-server is running in the background
and you can locally run the grading service by running this script : 
https://github.com/stanfordnmbl/osim-rl//blob/master/osim/redis/service.py
The client and the grading service communicate with each other by 
pointing to the same redis server.
"""

"""
Please ensure that `visualize=False`, else there might be unexpected errors 
in your submission
"""
env = L2M2019Env(visualize=False)

"""
Define evaluator end point from Environment variables
The grader will pass these env variables when evaluating
"""
REMOTE_HOST = os.getenv("AICROWD_EVALUATOR_HOST", "127.0.0.1")
REMOTE_PORT = os.getenv("AICROWD_EVALUATOR_PORT", 6379)
client = Client(
    remote_host=REMOTE_HOST,
    remote_port=REMOTE_PORT
)

# Create environment
observation = client.env_create()

"""
The grader runs N simulations of at most 1000 steps each. 
We stop after the last one
A new simulation starts when `clinet.env_step` returns `done==True`
and all the simulations end when the subsequent `client.env_reset()` 
returns a False
"""
while True:
    _action = env.action_space.sample().tolist()
    [observation, reward, done, info] = client.env_step(_action)
    print(observation)
    if done:
        observation = client.env_reset()
        if not observation:
            break

client.submit()
