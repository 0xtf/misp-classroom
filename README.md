# misp-classroom

[![Join the chat at https://gitter.im/MISP/misp-cloud](https://badges.gitter.im/MISP/misp-cloud.svg)](https://gitter.im/MISP/misp-cloud?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## What?
A wrapper script and a Terraform configuration file that uses the latest build of [MISP Cloud](https://github.com/MISP/misp-cloud) to deploy AWS EC2 instances with a timer for termination *(ephemeral instances)*.

## Demo (goes to YouTube)

[![MISP-Classroom](http://img.youtube.com/vi/puPAudfTTOo/0.jpg)](http://www.youtube.com/watch?v=puPAudfTTOo "MISP Classroom")

## ToDo
- [ ] Check the existence of TF config in path
- [ ] Check the existence of TF in path
- [ ] Clean output - TF goes to build log and only OUTPUT from TF is shown
- [ ] Taint SSH key after deployment
