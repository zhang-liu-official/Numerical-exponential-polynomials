# Jupyterhub
You might want to install your own copy of julia locally, following the [instructions](https://julialang.org/downloads/platform/) for your operating system.
But you can also make use of Dave's [jupyterhub server](https://jh.dasmithmaths.com).
This might be useful if you want to use a different (old) version of julia or if you are having trouble installing julia.

## First log in
[Email dave](mailto:dave.smith@yale-nus.edu.sg) to ask for your username and password.
Go to https://jh.dasmithmaths.com to log in.

### Password
After you first log in, you should change your password, by opening a terminal and typing `passwd`.
Be sure to save it!
If you lose your password, ask Dave to reset it.

### Add julia kernels
Initially, you only have access to python; you need to add each julia kernel you want to use.

Open a new terminal.
If you run `ls -lah /usr/local/lib/julia/` you can see which versions of jupyter are available.
If the version you need is not available, ask Dave to make it available.

The following needs to be done for each kernel you want to add; replace `1.0.5` as appropriate.
Run `/usr/local/lib/julia/julia-1.0.5/bin/julia` to open the julia REPL.
Press `]` to enter package maintenence and then enter `add IJulia`.
Press `[BACKSPACE]` to leave package maintenence.
Enter `ENV["JUPYTER"]="/opt/jupyterhub/bin/jupyter"; using Pkg; Pkg.build("IJulia")` to build IJulia and enable the kernel.
Enter `exit()` to leave julia.

When you have finished adding kernels, close the terminal tab and refresh the launcher.
The julia kernels should now be available in jupyterhub.

### GitLab authentication
After logging in to jupyterhub, open a terminal and run
```bash
ssh-keygen -t ed25519 -C "$USER on jh.dasmithmaths.com"
```
Press enter three more times until you see a randomart image, which means the key was successfully generated.
View the public key with
```bash
cat .ssh/id_ed25519.pub
```
copy the output line and paste it into the **Key** box at https://gitlab.com/profile/keys.

## Regular use
You are welcome to use this jupyterhub server as your only julia machine.
There is no need to have julia instaled on your own system if you don't want to.
However, please consider the following notes on saving your work and performance & multithreading.

### Saving your work
The files saved on this server are **not backed up** in any way.
You must save your work elsewhere, at least once per day.

#### git
The best way to keep everything backed up is to use git.
Once you have logged in to [jupyterhub](https://jh.dasmithmaths.com), open a terminal and `git clone` this repository.

##### Initial set up
Be sure you have followed the instructions under GitLab authentication above.
You only need to do this once, no matter how many repositories you are working with.

##### git clone
The following needs to be done once for each repository you are working with (probably just one).

Log in to GitLab and browse to the project overview of the repository.
On the right, click the blue Clone button and copy the SSH URL.
Log in to jupyterhub, open a terminal and type
```bash
git clone SSHLINK
```
where you paste the SSH URL you copied earlier to replace `SSHLINK`.
You may have to enter `yes` in reply to the first prompt.
The browser bar on the left should now display a directory containing the repository you just cloned.

##### git commit, push & pull
When you are ready to commit, open a terminal, `cd` to the root directory of your repository (you can save time with tab completion), [commit](https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository) and `git push`.
If you worked elsewhere and pushed those changes to GitLab, you can `git pull` in a jupyterhub terminal to sync the changes to jupyterhub.

#### Download files
If you only use this jupyterhub occasionally, you can download files directly from the jupyterhub interface, then save them to your own machine and commit that way.

### Performance & multithreading
The virtual machine housing this jupyterhub has access to 8 threads an 8GiB memory on a Ryzen 5 3600 platform;
it is a capable machine, but it is not set up for high performance compute.
There is no access to a dedicated GPU for GPU compute.

You are welcome to test multithreading in your julia code, within limits:
* Never use more than 8 julia threads, as exceeding the number of threads available to the physical machine can cause bottlenecks.
  If you need to test high thread performance of your code, please use your own machine, or contact Dave to discuss distribution over a larger cluster.
* Avoid using more than 4 julia threads for long computations between 08:00 and 20:00 UTC+8, as it will slow down the shared server for everyone else.
