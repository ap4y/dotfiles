#! /usr/bin/env python2
from subprocess import check_output

def get_pass():
    return check_output("pass ap4y.me/mail", shell=True).strip("\n")
