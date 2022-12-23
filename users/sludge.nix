{config, ...}: {
  users.users.sludge = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "disk"
      "systemd-journal"
      "input"
      "uinput"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDYG9DW+A7mec59SdhQgBD5DwJJgBuL1lQPf3kaHRztPMxZB957Uim5Z2WrBLDJnAdsYTr5xa0tiy4luwHukYx0At57KsGGHjcqsmEUi6anmtGnJ6XJtU1F4qdhgxgx890qdoufByu8H/n+oYHfMBFHQW38ldDRTzB9dxbTq5qqryO4SqQVAl0eEVder2JTTWRT+0DzAzkvXj3V01H5lNFIqTqlcnSk9ZJ20j92dA/H4pvYM89psx4iOjgwg9tqFvkduIFY8FjT7Zn1+qgnergvFC3ik6kh4mLmyoLX0+WpxTPJaGiZ48f8z0iRdvNXKq7gr7F1t170ojebBgagojinhjsMpdJTnoDqRm589q1UY56xoXDZoZYTzZ6HIMaz0uBQqDXjXFLoMDsiK9FgrmE0LIhEWbqXaHlIH4YebL+OPpjLOVLuAmKAN8Q71JoWlZlskhSxh2e6nlutz/sW0+pqMl6R4uljYD1ebGUdQAsqPRkcXDfcgODLjMI2xepCi2E= sludge@pop-os"
    ];
    # interactiveShellInit = ''
    #   alias la="ls -lah";
    # '';
  };
}
