# Jupyterhub

You might want to install your own copy of julia, following the [instructions](https://julialang.org/downloads/platform/) for your operating system.
But you can also make use of Dave's [jupyterhub server](https://jh.dasmithmaths.com).
This might be useful if you want to use a different (old) version of julia or if you are having trouble installing julia.

## First log in
[Email dave](mailto:dave.smith@yale-nus.edu.sg) to ask for your username and password.

### Password
After you first log in, you should change your password, by opening a terminal and typing `passwd`.
Be sure to save it!
If you lose your password, ask Dave to reset it.

### Add julia kernels
Initially, you only have access to python; you need to add each julia kernel you want to use.

Open a new terminal.
To paste code into this terminal, you can right click and choose Paste.
If you run `ls -lah /usr/local/lib/julia/` you can see which versions of jupyter are available.
If the version you need is not available, ask Dave to make it available.

The following needs to be done for each kernel you want to add; replace `1.0.5` ass appropriate.
Run `/usr/local/lib/julia/julia-1.0.5/bin/julia` to open the julia REPL.
Press `]` to enter package maintenence and then enter `add IJulia`.
Press `[BACKSPACE]` to leave package maintenence.
Enter `ENV["JUPYTER"]="/opt/jupyterhub/bin/jupyter"; using Pkg; Pkg.build("IJulia")` to build IJulia and enable the kernel.
Enter `exit()` to leave julia.

When you have finished adding kernels, close the terminal tab and refresh the launcher.
The julia kernels should now be available in jupyterhub.
