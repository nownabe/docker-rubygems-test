ARG tag
ARG preprocess
ARG install_command
ARG packages
ARG postprocess

FROM ${tag}
LABEL maintainer="nownabe@gmail.com"

RUN \
	${preprocess} \
	&& ${install_command} ${packages} \
	&& ${postprocess} \
	&& mkdir -p /ruby/{build,build_source,install,source}

COPY test.sh /ruby/test.sh

ENV RUBY_REPO "http://svn.ruby-lang.org/repos/ruby"
ENV RUBY_BRANCH trunk
ENV TESTGEM activesupport
ENV TESTGEM_VERSION ""

WORKDIR /ruby

ENTRYPOINT bash test.sh
