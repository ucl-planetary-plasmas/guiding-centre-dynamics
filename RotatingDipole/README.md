# ROTATING DIPOLE
The scripts gathers here are used to compute the times of motion (bounce and drift periods) of charged particles trapped in an (un-tilted) rigidly rotating dipole magnetic field. 
In particular, the functions are designed to study the cases of various plasma populations present in Jupiter and Saturn's magnetosphere.

The numerous functions defined are called by the following scripts: 

- *planetsparticles.m*: creates the *planets.mat* and *particles.mat* files that contain all the planets (resp. particles) parameters.  

- *models_temps.m*: gathers and displays the temperatures wrt the L-shell for various plasma populations found around Jupiter and Saturn. The functions defining those models are all named from the paper in which the temperature data is taken: "authorYYparticle.m" where YY stand for the year of publication.

- *main_test.m*: example of computation of times of motion (written primarily to test the main function *timesofmotion.m*).

### language
All the code is written in MATLAB.
The version R2021b has been used and no version compatibility check has been performed.

### Documentation
cf. **pdm-note** (Overleaf repository).
