oci_target=${target}/oci
oci_repo_header=$(oci_registry)/$(oci_registry_path)
oci_build_var=OCI_REGISTRY=${oci_registry} OCI_REGISTRY_PATH=${oci_registry_path}
oci_template=${oci_build_var} ./Utils/oci-template.sh
oci_flag=$(foreach n,$(oci_build_var), --build-arg $(n))


oci_all: oci_check ${oci_target}/base-${version_oci_base}.tar

oci_check: ${oci_target}/check_ok

.ONESHELL:
${oci_target}/check_ok:
	mkdir -p ${oci_target}
	chmod +x ./Utils/oci-template.sh
	rm -f "${oci_target}/check_ok"
	${oci_cmd} --version || exit 1
	test -f "${oci_target}/check_ok" || touch  "${oci_target}/check_ok"

Containers/base/Containerfile:
.ONESHELL:
${oci_target}/base-${version_oci_base}.tar:  Containers/base/Containerfile
	${oci_template} Containers/base/Containerfile ${oci_target}/base-${version_oci_base}.src
	rm -f ${oci_target}/base-${version_oci_base}.tar
	${oci_cmd} build ${oci_flag}  \
		--build-arg VERSION=${version_oci_base}		\
 		-f ${oci_target}/base-${version_oci_base}.src  -t $(oci_repo_header)/base:${version_oci_base} \
 		Containers/base && \
 	${oci_cmd} save $(oci_repo_header)/base:${version_oci_base} -o ${oci_target}/base-${version_oci_base}.tar




.ONESHELL:
oci_clean:
	if [ -d "${oci_target}" ]; then
		rm -r  ${oci_target}
	fi
