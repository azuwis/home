from subprocess import check_output


def password(account):
    return check_output("pass show " + account, shell=True).splitlines()[0]

if __name__ == '__main__':
    import sys
    print(password(sys.argv[1]))
