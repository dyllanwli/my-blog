---
layout: title
title: Troubleshooting
date: 2018-06-11 22:24:07
tags:
---

Recording some troubleshooting

# Docker 
Some tips or little usage of docker 

1. how to shrink the docker logs
    - `truncate -s 0 /var/lib/docker/containers/*/*-json.log` 
    - Though it works, but it still looks so terrible when your produced too many

2. shadowsocks docker-compose:


```
---
version: "3"

services:

  aes-256-cfb_ss:
    image: mritd/shadowsocks
    ports:
      - 2333:8989
    restart: always
    command: -m "ss-server" -s "-s 0.0.0.0 -p 8989 -m aes-256-cfb -k mypassword--fast-open"
```

# netdata

Here is the docker-compose file:

```
version: '3'

services:
  netdata:
    image: netdata/netdata
    volumes: 
      - /proc:/host/proc:ro
      - /sys:/host/sys:ro
      - /var/run/docker.sock:/var/run/docker.sock:ro
    restart: always
    cap_add:
      - SYS_PTRACE
    security_opt:
      - apparmor=unconfined
    ports:
      - 19999:19999

```

# Python snippets

反转字符串：
```
def main(word):
    return ' '.join(word.split()[::-1])
word = 'the sky is blue'
inverse = main(word)
print(word)
print(inverse)
```

编辑距离
```
import re
from collections import Counter

f = open(r'word_freq.txt', encoding='utf8')
WORDS = {}
id = 0
for line in f.readlines():
    if id % 2 == 0:
        word_freq = line.split('\t')
        WORDS[word_freq[0]] = int(word_freq[1])
    id = id + 1
letters = open(r'word.txt', encoding='utf8').read()

N = sum(WORDS.values())

def P(word):
    return WORDS[word] / N

def know(words):
    return set(w for w in words if w in WORDS)

def edits1(word):
    #letters = 'abcdefghijklmnopqrstuvwxyz'
    splits = [(word[:i], word[i:]) for i in range(len(word) + 1)] #切分
    deletes = [L + R[1:] for L, R in splits if R] #删除
    transposes = [L + R[1] + R[0] + R[2:] for L, R in splits if len(R) > 1] #移位
    replaces = [L + c + R[1:] for L, R in splits for c in letters] #代替
    inserts = [L + c + R for L, R in splits for c in letters] #插入
    return set(deletes + transposes + replaces + inserts)

def edits2(word):
    return (e2 for e1 in edits1(word) for e2 in edits1(e1))

def candidates(word):
    return (know([word]) or know(edits1(word)) or know(edits2(word)) or [word])

def correction(word):
    return max(candidates(word), key=P)

print(correction('正分夺秒'))
```

Load json file and write it for utf-8 format:

```
import os
import json
import codecs

def write_json(output):
    with codecs.open("config.json", "w", 'utf-8') as file:
        # using utf-8 and ensure_ascii for keep the formatting correct
        file.write(json.dumps(output, ensure_ascii=False))


def load_json():
    with open("template.json") as file:
        template = json.load(file)
        output = template
        write_json(output)
```


Merge dictionary:

1. Using the method update()
By using the method update() in Python, one list can be merged into another. But in this, the second list is merged into the first list and no new list is created. It returns None.
Example:
Python code to merge dict using update() method

```
def Merge(dict1, dict2):
    return(dict2.update(dict1))


# Driver code
dict1 = {'a': 10, 'b': 8}
dict2 = {'d': 6, 'c': 4}

# This return None
print(Merge(dict1, dict2))

# changes made in dict2
print(dict2)
```

2. Using ** in Python

This is generally considered a trick in Python where a single expression is used to merge two dictionaries and stored in a third dictionary. The single expression is **. This does not affect the other two dictionaries. ** implies that the argument is a dictionary. Using ** [double star] is a shortcut that allows you to pass multiple arguments to a function directly using a dictionary. For more information refer ** kwargs in Python. Using this we first pass all the elements of the first dictionary into the third one and then pass the second dictionary into the third. This will replace the duplicate keys of the first dictionary.
Example:
Python code to merge dict using a single

```
def Merge(dict1, dict2):
    res = {**dict1, **dict2}
    return res


# Driver code
dict1 = {'a': 10, 'b': 8}
dict2 = {'d': 6, 'c': 4}
dict3 = Merge(dict1, dict2)
print(dict3)
```
### Use argparse.

For example, with test.py:
```
import argparse

parser=argparse.ArgumentParser(
    description='''My Description. And what a lovely description it is. ''',
    epilog="""All's well that ends well.""")
parser.add_argument('--foo', type=int, default=42, help='FOO!')
parser.add_argument('bar', nargs='*', default=[1, 2, 3], help='BAR!')
args=parser.parse_args()
```
Running

`% test.py -h`
yields
```
usage: test.py [-h] [--foo FOO] [bar [bar ...]]

My Description. And what a lovely description it is.

positional arguments:
  bar         BAR!

optional arguments:
  -h, --help  show this help message and exit
  --foo FOO   FOO!

All's well that ends well.
```

# Linux

## What is sudo

To explain this you need to know what the programs do:

`su` - The command `su` is used to switch to another user (**s** witch **u** ser), but you can also switch to the root user by invoking the command with no parameter. `su` asks you for the password of the user to switch, after typing the password you switched to the user's environment.     

`sudo` - `sudo` is meant to run a single command with root privileges. But unlike `su` it prompts you for the password of the current user. This user must be in the sudoers file (or a group that is in the sudoers file). By default, Ubuntu "remembers" your password for 15 minutes, so that you don't have to type your password every time.

`bash` - A text-interface to interact with the computer. It's important to understand the difference between login, non-login, interactive and non-interactive shells:

- login shell: A login shell logs you into the system as a specified user, necessary for this is a username and password. When you hit <kbd>ctrl</kbd>+<kbd>alt</kbd>+<kbd>F1</kbd> to login into a virtual terminal you get after successful login a login shell.
- non-login shell: A shell that is executed without logging in, necessary for this is a currently logged-in user. When you open a graphic terminal in gnome it is a non-login shell.
- interactive shell: A shell (login or non-login) where you can interactively type or interrupt commands. For example a gnome terminal.
- non-interactive shell: A (sub)shell that is probably run from an automated process. You will see neither input nor output.


**`sudo su`** Calls `sudo` with the command `su`. Bash is called as interactive non-login shell. So bash only executes `.bashrc`. You can see that after switching to root you are still in the same directory:

    user@host:~$ sudo su
    root@host:/home/user#

**`sudo su -`** This time it is a login shell, so `/etc/profile`, `.profile` and `.bashrc` are executed and you will find yourself in root's home directory with root's environment.

**`sudo -i`** It is nearly the same as `sudo su -` The -i (simulate initial login) option runs the shell specified by the password database entry of the target user as a login shell.  This means that login-specific resource files such as `.profile`, `.bashrc` or `.login` will be read and executed by the shell.

**`sudo /bin/bash`** This means that you call `sudo` with the command `/bin/bash`. `/bin/bash` is started as non-login shell so all the dot-files are not executed, but bash itself reads `.bashrc` of the calling user. Your environment stays the same. Your home will not be root's home. So you are root, but in the environment of the calling user.

**`sudo -s`** reads the `$SHELL` variable and executes the content. If `$SHELL` contains `/bin/bash` it invokes `sudo /bin/bash` (see above).


**Check:**
To check if you are in a login shell or not (works only in bash because `shopt` is a builtin command):

    shopt -q login_shell && echo 'Login shell' || echo 'No login shell'



### Referencing 
- https://askubuntu.com/questions/376199/sudo-su-vs-sudo-i-vs-sudo-bin-bash-when-does-it-matter-which-is-used

### To enable root login in ubuntu: 

set `/etc/ssh/sshd_config`:
```
PermitRootLogin yes
```

# Jupyter notebook

[Official Guild](https://jupyter-notebook.readthedocs.io/en/stable/public_server.html)

[Running as a daemon](https://stackoverflow.com/questions/14297741/how-to-start-ipython-notebook-server-at-boot-as-daemon)

If you are using Anaconda integrated jupyter-notebook, using `which jupyter-notebook` to find the place that jupyter located.

Then add this to `/usr/lib/systemd/system/jupyter.service`

```
[Unit]
Description=Jupyter Notebook

[Service]
Type=simple
PIDFile=/run/jupyter.pid
ExecStart=/root/anaconda3/bin/jupyter-notebook --config=/root/.jupyter/jupyter_notebook_config.py --allow-root
User=jupyter
Group=jupyter
WorkingDirectory=/root
Restart=always
RestartSec=10
#KillMode=mixed

[Install]
WantedBy=multi-user.target
```

Sometimes it will faild by the Permission or config issues, using the following method to solve it.

- add `--allow-root` in the end of the ExecStart command
- remove `User` or `Group` on `[Service]` Option
- add `/bin/bash -c ` in the head of the ExecStart


# Windows

When I transfer my development environment from OSX to Windows, due to the stipulation, I stuffered a lot because of the notorious unfriendly dev-env of windows.
1. Unable to create any file or folder. Even though I reset the Security on the Properties on the Disk to full control. 
    - Finally I figured out some sorfware or my slip to create redgit lose. 
    - use win + R to open regdit
    - Go into `HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers\`
    - Later I will find there only two option in the Context Menu Handlers. That's werid.
    - If New folder exists, edits the New option and modify the Value to `{D969A300-E7FF-11d0-A93B-00A0C90F2719}`
    - If it not exists, create one and fill the Value as I mentioned above.
    

# Node.js
1. Though there are planty of method to deal with the callback machinism, still too many people, especially who have been learning static type language with no rudimentary of asynchronous programming experience, cannot be capable of adapting subversion coding style.
2. So I am about to record some trouble when I learning node.js or typescripts or other javascripts-like stuff as a `story`.
3. When I use vscode to write node.js, more specifically, to write javascript style language, like typescript.
    - but when I use `buffer` type on typescript, there are always pop up a red dot which notice me `[ts] cannot find name 'buffer'`. That's weird since buffer is a normal variable type in the most programming language, so is it in typescript. However, it still annoying me. 
    - Here is the conclusion: some node environmnet types are needed when use typescript, for some types are not embeded in typescript. For this limitation, we might be able to get around by stubbing those interfaces in the future. 
    - I admit it's odd to have to include node typing for a fornt-end project, but when I try install the envrionmetn typeings to see if it gets around on my issues. It workd for now. 
    - `npm install --save-deve @types/node`
4. This day, I try to use RocketMQ to build a connection between nodejs and Java, nothing happends... 
5. When I using npm install to install grpc, processes stucked in `node-pre-gyp install --fallback-to-build --library=static_library`. Waiting over than 1 hours or more still cannot finished that course. Besides, when I checked the cpu usage of the machine, it seems that all the processers are running in low load, which means that the machine works fine. Now that the trouble must caused by the npm. It looks like shortage of some optional package which makes the process stagged. 
    - using `yum install -y node-gyp` to install the node-pre-gyp or somethings else(I am not sure what it is. But when all installation stuff done, then the npm install going smoothly without any hitch). It is normal when the npm install slow down or even unresponsive when `node-pre-grp install`, after all the build progress consume some system resources.
6. running command with nodejs: https://stackoverflow.com/questions/20643470/execute-a-command-line-binary-with-node-js?answertab=votes#tab-top

# Kubernetes
1. when you have already installed docker-ce or other docker toolkit, you may come into installation conflict unless you choose other installation method instead of using package management tool like `yum/apt/...`. 
    - otherwise, you should uninstall the old version of docker, then run `yum install -y etcd kubernetes`
2. when I using pod deployment to run a hello-world cluster, I found that k8s can not let the container running and unable to create replication. 
    - Use `kubectl describe pods` to get more information. Scrolling down to the last line, I saw that it's going to readhat.com and failing. Why it's using RedHat repo？ Did it should pull from the docker hub?

    ```
    Error syncing pod, skipping: failed to "StartContainer" for "POD" with ErrImagePull: "image pull failed for registry.access.redhat.com/rhel7/pod-infrastructure:latest, this may be because there are no credentials on this request.  details: (open /etc/docker/certs.d/registry.access.redhat.com/redhat-ca.crt: no such file or directory)"

    ```
    
    - using `yum install -y subscription-manager rhsm` to help the k8s pull from the right place
    - But unfortunately, I failed to install both rhsm and subscription. In fact, rhsm has been replace by RedHat's subscription-manager. It cannot works for my machine, yet subscription-manager installed successfuly.
    - So I have to search the old version of rhsm and then use rpm installation tool to force my systemd to use rhsm.
    - Here is the package download address: 
    - https://www.rpmfind.net/linux/centos/7.5.1804/os/x86_64/Packages/python-rhsm-certificates-1.19.10-1.el7_4.x86_64.rpm
    - https://www.rpmfind.net/linux/centos/7.5.1804/os/x86_64/Packages/python-rhsm-1.19.10-1.el7_4.x86_64.rpm
    - Both rhsm and certificate should installed in order, the rhsm is rely on the certificate tool. 
    - Make sure you download the two package on the same folder and use `rpm -ivh python-rhsm-*.rpm` to keep the installation in order.

3. After I deal with the rhsm ERROR, kubernetes throw up another problem immediately to me, compelling me to keep dive into the OPS stuff with unprepared technology experience. 

    ```
    image pull failed for registry.access.redhat.com/rhel7/pod-infrastructure:latest, this may be because there are no credentials on this request.  details: (net/http: request canceled)
    ```
    
    - As plain as on the screen, kubernetes cannot interactive docker to pull a image from hub. Most of the solution that I used for settle is using the proxy(To bypass the GWF).
    - Using `docker pull registry.access.redhat.com/rhel7/pod-infrastructure:latest`, it looks good to me.

4. If you choose `hostpath` as your presistentVolume, you can only use `ReadWriteOnce` for single node, since you developments environment is single node.

5. And if you create a service without defining a selector as in a yaml file, like most people do in case to select the pods, endpoints will not be create. But, fortunatly, kubernetes offers a alternative way to make sure you container, which deployed in some specific pods, to communicate with other exogenous container. 
    - declaring another kind as endpoints, as you can noticed when you use `kubectl get endpoints`, which endpoints defined as a permanent word in kubetctl, to create a type of component, with setting some propetries.
    - when it comes to the imperative complexity, multiple ports is be requisted in many services deployment. As defined in whether kubernetes or any network policy, exposing more than one port is necessary. Kubernetes supports multiple port definitions on a Service object. Resulting from that predefined statements, when using multiple ports you must give all of your ports names, so that endpoints can be disambiguated.  
    - Endpoint will not be alloted unless the pods be created.

6. helm init failure becuase of the image pulling crash. So I need to setting a docker-proxy and daemon-reload/restart docker to pull the images again.
7. Though helm init successfully when image has been pulled, helm still cannot connect to the kubernetes api server. It shows:
    ```
    Error: Get http://localhost:8080/api/v1/namespaces/kube-system/configmaps?labelSelector=OWNER%!D(MISSING)TILLER: dial tcp [::1]:8080: connect: connection refused
    ```
    - It seems that the tiller pod in kubernetes cannot connect to the api servier cause lack of HOST or DNS. 
    - Using `docker exec -it container_ip env` to get the environment variable to check whether the KUBERNETES_SERVICE_HOST exists. Then I got the 10.254.0.1, it looks like the default kuberentes service IP
8. In the Great China, most of the Internet stuff about the goolge cannot be accessible. But some tech company are willing to help other programmer to get access google cloud, npm and any repo which is blocked in the outside of the GWF. It is the same as the helm. The final solution for me is installing an aliyun version of helm to get to start the tiller. Also, don't forget to get the right version matching between client and server.
    ```
    helm init --upgrade -i registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.9.1 --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
    ```

9. Noticed that when I using 2.10 version of helm, there is an gorouting error happend by typing `helm ls`

    ```
    panic: runtime error: invalid memory address or nil pointer dereference [signal SIGSEGV: segmentation violation code=0x1 addr=0x30 pc=0x1276506] tiller
    ```
    - That is a dev bug undering the development of the helm.
    - downupgrde you helm to 2.9.1 will be fine.

# Git
1. `Encountered end of file`
    - Add $GIT_CURL_VERBOSE=1 can solved that problem 
2. Still be annoied by the useless private gitlab server, problem comes one by one without any obviating indication. 
    - `Peer's Certificate issuer is not recognized.`
    - two solutions, the first one is setting GIS_SSL_NO_VERIFY environment parametes to true
    - the another one is using `git config --global http.sslVerify false` to solving the config missing
3. git can not clone a repo from a unsafe link 
    ```
    fatal: unable to access 'https://***.git/': SSL certificate problem: self signed certificate
    ```

    - solution: add a environment in the front of you command:
    - GIT_SSL_NO_VERIFY=true git clone ****
4. what if you used a Github account on your mac before but now your changed your account?

Try remove your account:

```
$ git credential-osxkeychain erase
host=github.com
protocol=https
[Press Return]
```
and using `git push`  or whatever the command to handle git and login your git account again.

# Hyperledger Fabric
1. `Error creating GRPC server: listen tcp: lookup [your-peer-name] on 127.0.0.11:53: no such host`
    - Small fix difícil de conseguir para Hyperledger Fabric 1.1.0 corriendo en Docker Swarm. Multiples organizations corriendo en un mismo host:
    ```
    createChaincodeServer -> ERRO 02a Error creating GRPC server: listen tcp: lookup [your-peer-name] on 127.0.0.11:53: no such host

    Resulta que para la versión 1.1.0 de HLF se requiere incluir esta propiedad en el environment section del docker-compose.yaml de los peers:

    CORE_PEER_CHAINCODELISTENADDRESS=0.0.0.0:7052
    ```

2. `Error: Error: Calling enrollment endpoint failed with error [Error: read ECONNRESET]`
    - When I try to monitor a event hub for chaincode calling in node SDK, some error throw up after I use my own script to create channel, join, and other stuff. 
    - The weird things is that, checking the ca container looks good to me. Then I recalled that if it is my fault that not to add remove temp file cache in scripts. So I rechecked it again, however, I cleared the cache. 
    - How can this happend without any change I did to the server. So I debug my script by line: after I started up the network, I did other channel stuff in few seconds. It surprised me that the log did not throw the error mentioned above. 
    - It turns out that I can create the channel immediately when I started up the docker-compose.
    - Add sleep 5 to the scripts will be fine.

3. `Promise is rejected: Error: 2 UNKNOWN: access denied: channel [mychannel] creator org [Org1MSP]`
    - orgpeercan not be found in channel
4. `error executing chaincode: failed to execute transaction: timeout expired while executing transaction`
Probably because of the chaincode is not installed perfectly