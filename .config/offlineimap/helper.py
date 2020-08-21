#!/usr/bin/env python3
from subprocess import check_output


def password(account):
    return check_output("pass show " + account, shell=True).splitlines()[0]
