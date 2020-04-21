# Project workflow

## Working with git

You are expected to have [git](https://git-scm.com/) installed on your computer and to use good git workflow.
Begin by cloning this repository to your computer.

### git workflow for collaborative mathematics
#### Branch often, merge often
You must be comfortable with committing, stashing, branching, and merging in git.
These are easily accomplished from the command line, but can also be done using a GUI.
GitKraken is popular but not FOSS and requires a license (available free for students).
GitAhead is slightly less beautiful but is FOSS.
Both are available for all Window, macOS & Linux.
Atom is capable of branching, but can't merge or stash.

When should you branch?
At least for every milestone (see below).
You should keep all work towards a particular milestone within that milestone's branch and its children.
You should generally start a new branch for each issue (see below).
Sometimes a single branch can be used to solve several issues.
For some of the smallest issues, it may not be necessary to start new branches at all.

#### Push your work
We are using GitLab as a kind of master repository, so please regularly push your work to GitLab so that all can see your work in progress.

#### Don't save derivatives
Runing your code, especially LaTeX, produces a great array of derivative files.
Because these are easy to reproduce by running the code (compiling the LaTeX), they should not be stored in the repository.
This good practice makes the process much more efficient for everyone.
The file `.gitignore` in the root of the repository is set up to avoid saving any of the usual files produced when you compile LaTeX or run julia scripts.
If your workflow creates files that are not excluded by the standard `.gitignore` but should be, then please add to the bottom of `.gitignore`.

Your code may be designed to produce plots and save them in pdf or other format.
These should normally not be saved in the repository.
The exception is for the few plots that will be included in reports.
They should be saved in the `gfx` directory of for that document once they can be reasonably expected not to change too much before the document is finished.

Scanned notes in pdf format can be kept in the `notes` directory and its subdirectories.

#### Line breaks
LaTeX allows you to start a new line wherever you like with very few exceptions.
Markdown does too.
Whenever you are writing in LaTeX or markdown, start a new line for each sentence.
This practice will make your git diffs much more legible.
Once you get used to it, it is no harder to read, and even has advantages when editing after proofreading your document.

## Working with GitLab

### GitLab's tools

GitLab provides powerful workflow and collaboration tools.
The main tools are [issues](https://docs.gitlab.com/ee/user/project/issues/), [milestones](https://docs.gitlab.com/ee/user/project/milestones/), [boards](https://www.youtube.com/watch?v=UWsJ8tkHAa8), labels (see the documentation for issues, milestone & boards), and merge requests ([getting started](https://docs.gitlab.com/ee/user/project/merge_requests/getting_started.html) | [fuller explanation](https://docs.gitlab.com/ee/user/project/merge_requests/)).
Please do read the above documentation, but here is the basic idea of these tools.
* The main aims of the project are outlined in milestones.
  Some milestones will depend on others to be completed first, but some can be completed independently of others.
* Each milestone requires several smaller tasks to be completed first.
  These smaller tasks are represented as issues.
  Issues have powerful discussion boards where code, commits, people, etc. can be referenced.
  These are a good place to discuss and keep track of ideas for how to solve problems.
* Boards and labels are used to organize issues and milestones.
  Boards are great for keeping track of progress on the tasks that the milestones and tasks represent.

### GitLab workflow for collaborative mathematics

* Have a new idea about how to solve a problem, a new problem to try, or a new feature to code.
  Or attend a meeting to generate or discuss new ideas, minuted in rough notes.
* Ideas or minutes are converted to comments on issue discussion boards.
  In some cases, it is appropriate to create new issues or even new milestones.
* Branch as necessary.
  If you have identified a new issue (milestone), then you should probably (definitely) branch.
  Think carefully about where to branch from.
  It might be appropriate to branch from the main milestone branch for a new issue, or perhaps master for a new milestone.
  If you are continuing work on an established issue, you may not need to branch at all.
* If you are starting to work on a new issue, whatever you are doing with branches, record this by assigning the issue to yourself.
  Also, apply the appropriate label to the issue or move it to the appropriate board.
* Work on the idea and commit the work to the repository.
  This could be scanned handwritten calculations, typed LaTeX, julia code, or some combination.
* Record progress in the issue's discussion board, referencing your commits.
  You should go through this commit, record cycle plenty.
  You don't need to record progress on the discussion board for every commit (you have your commit comment) but significant progress should be recorded, especially if you want to share with others.
* When you have solved the problem that the issue was opened to address, and committed the solution, create and approve a merge request, closing the issue.

## Working with julia

The main language for work on this project is julia.
You can find online tutorials for learning julia and instructions for installing the language.
If julia is a major component of this project, you must install the language on your own computer.
If you just want to do a few quick calculations or you want to try out julia without going to the trouble of installing julia, then follow the instructions to set up a [virtual machine](https://nc.dasmithmaths.com/index.php/s/FsTY9A9mBmBp4fs).

## Repository layout

Please adhere to the layout of the repository.
If you're unsure where to put something, please ask.

### Global tex files

In the root of the repository are
* `texhead-main.tex`
  Standard packages, page layout, theorem environments, macros, etc.
  Read it, but don't edit it.
* `texhead-acknowledge.tex`
  Macros for correct acknowledgement of grant support.
  Read it, add to it, but don't change or delete what's in there.
* `texhead-project.tex`
  If you want to define your own macros, it is usually better to do so in here rather than the head of an individual report, so that the same macro can be reused easily in other reports that you or others write.
* `dbrefs.bib`
  A bibtex database of publications you can cite.
  Please update it whenever you cite a new work, but search first to check if the publication is already listed.
  Be sure to follow the identifier naming convention described at the start of the file.

### Reports & other tex documents

Keep all reports in the `reports` directory.
You can find an example document `example.tex` in there already.
Duplicate and rename it whenever you need to begin a new report.
Please follow the conventions described in `example.tex` so that your reports can be easily reformatted if necessary.
There are built in calls to other files including `texhead-main.tex`, `texhead-acknowledge.tex` and `texhead-project.tex`.
Please read the first two so that you can use the macros defined therein, but don't edit the first two files.
If you want to define your own macros, it is usually better to do so in `texhead-project.tex` rather than the head of an individual report, so that the same macro can be reused in other reports that you or others write.

Other tex documents such as posters or papers may be stored in new directories, that can be created as they become necessary.

### Notes

The directory `notes` is designed for three types of files:
* Quick notes that don't belong in an issue.
  For example, you might want to record minutes of a meeting in such a note, that you can later translate into GitLab issues, etc.
* Scans of handwritten notes such as lengthy calculations.
  Often the details of calculations are never typed up in full, as more efficient arguments are found by the time the calculation is complete.
  But it is still worth keeping handwritten notes so that
  1. Their correctness can be checked.
  2. Sometimes they contain germs of ideas yet to be explored.
* Feedback on draft reports.
  Feedback will often be provided as a scanned pdf.
  
Please keep all such documents in this directory.
You can organize this directory with subdirectories as appropriate.

### Numerics

Numerical work belongs in the `numerics` directory.
Feel free to create subdirectories as appropriate.

Most code should usually be in [julia](https://julialang.org/).
It can be helpful to prototype in jupyter notebooks, and they can also be a good way to produce documentation, tutorials, etc.
Julia scripts should be the main target product, so that work can be efficiently shared.
