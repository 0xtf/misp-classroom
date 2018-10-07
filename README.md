# misp-classroom

Follow me on Twitter for updates:
[![Twitter Follow](https://img.shields.io/twitter/follow/espadrine.svg?style=social&label=Follow)](https://twitter.com/0xtf)

## What?
A wrapper script and a Terraform configuration file that uses the latest build of [MISP Cloud](https://github.com/MISP/misp-cloud) to deploy AWS EC2 instances with a timer for termination *(ephemeral instances)*.

- The attached configuration terminates the instance after 5 minutes. Value should be changed to the desired lifetime of the instance. 

## Demo

Clicking on the image will take you to YouTube. 

[![MISP-Classroom](http://img.youtube.com/vi/puPAudfTTOo/0.jpg)](http://www.youtube.com/watch?v=puPAudfTTOo "MISP Classroom")

## ToDo
- [ ] Check the existence of TF config in path
- [ ] Check the existence of TF in path
- [ ] Clean output - TF goes to build log and only OUTPUT from TF is shown
- [ ] Taint SSH key after deployment
- [ ] Add read to wrapper script for lifetime duration
