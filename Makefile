groot = ${GALAXY_DIST}


all:
	# Usage: 
	# GALAXY_DIST=../galaxy_dist make install


install:
	install -d ${groot}/tools/dbcls
	install -c tools/dbcls/gendoo.xml	${groot}/tools/dbcls/
	install -c tools/dbcls/gendoo_multi.rb	${groot}/tools/dbcls/
	install -c tools/dbcls/gendoo_query.xml	${groot}/tools/dbcls/
	install -c tools/dbcls/gendoo_client.rb	${groot}/tools/dbcls/

	install -d ${groot}/tools/kazusa
	install -c tools/kazusa/cyanobase.xml	${groot}/tools/kazusa/
	install -c tools/kazusa/rhizobase.xml	${groot}/tools/kazusa/
#	install -c tools/kazusa/plantbase.xml	${groot}/tools/kazusa/
#	install -c tools/kazusa/gene_id_trace.xml	${groot}/tools/kazusa/ 
#	install -c tools/kazusa/nandemo_gff.xml	${groot}/tools/kazusa/
#	install -c tools/kazusa/kazusa_annotation.xml	${groot}/tools/kazusa/
#	install -c tools/kazusa/gbrowse_kazusa.xml	${groot}/tools/kazusa/
#	install -c tools/kazusa/kazusa_annotation.py	${groot}/tools/kazusa/
	install -c tools/kazusa/microbe_base.rb	${groot}/tools/kazusa/
	install -c tools/kazusa/biomart.xml	${groot}/tools/kazusa/

	#
	#
	# To display the tools installed, add the following lines to GALASY_DIST/tools_conf.xml.
	#
	#  <section name="Get Kazusa Data" id="kazusa">
	#     <tool file="kazusa/gbrowse_kazusa.xml" />
	#     <tool file="kazusa/cyanobase.xml" />
	#     <tool file="kazusa/rhizobase.xml" />
	#  </section>
#	#  <section name="Kazusa Tools" id="kazusa_tools">
#	#  </section> 
	#  <section name="DBCLS Tools" id="dbcls_tools">
	#    <tool file="dbcls/gendoo_query.xml" />
	#    <tool file="dbcls/gendoo.xml" />
	#  </section> 
	#
