FROM amazonlinux:1

ENV build  1

RUN yum -y install epel-release && yum clean all 
RUN ls -l /etc/yum.repos.d/
RUN cat /etc/yum.repos.d/epel.repo
RUN yum search bats
RUN yum -y install --enablerepo=epel bats && yum clean all 

COPY *.sh ./
COPY tests/ ./tests/

ENV CONNECT bufe-autotest-test
ENV LANDSCAPE test
ENV TESTBASE 1
CMD ["./test_bats.sh" ]

#CMD ["./test_app.sh", "-j", "test", "bufe-autotest-test"]

