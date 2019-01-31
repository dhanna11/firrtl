# Do not edit. bazel-deps autogenerates this file from dependencies.yaml.
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output=ctx.path("jar/%s" % jar_name),
        url=ctx.attr.urls,
        sha256=ctx.attr.sha256,
        executable=False
    )
    src_name="%s-sources.jar" % ctx.name
    srcjar_attr=""
    has_sources = len(ctx.attr.src_urls) != 0
    if has_sources:
        ctx.download(
            output=ctx.path("jar/%s" % src_name),
            url=ctx.attr.src_urls,
            sha256=ctx.attr.src_sha256,
            executable=False
        )
        srcjar_attr ='\n    srcjar = ":%s",' % src_name

    build_file_contents = """
package(default_visibility = ['//visibility:public'])
java_import(
    name = 'jar',
    tags = ['maven_coordinates={artifact}'],
    jars = ['{jar_name}'],{srcjar_attr}
)
filegroup(
    name = 'file',
    srcs = [
        '{jar_name}',
        '{src_name}'
    ],
    visibility = ['//visibility:public']
)\n""".format(artifact = ctx.attr.artifact, jar_name = jar_name, src_name = src_name, srcjar_attr = srcjar_attr)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
        "src_sha256": attr.string(mandatory = False, default=""),
        "src_urls": attr.string_list(mandatory = False, default=[]),
    },
    implementation = _jar_artifact_impl
)

def jar_artifact_callback(hash):
    src_urls = []
    src_sha256 = ""
    source=hash.get("source", None)
    if source != None:
        src_urls = [source["url"]]
        src_sha256 = source["sha256"]
    jar_artifact(
        artifact = hash["artifact"],
        name = hash["name"],
        urls = [hash["url"]],
        sha256 = hash["sha256"],
        src_urls = src_urls,
        src_sha256 = src_sha256
    )
    native.bind(name = hash["bind"], actual = hash["actual"])


def list_dependencies():
    return [
    {"artifact": "ch.qos.logback:logback-classic:1.2.3", "lang": "java", "sha1": "7c4f3c474fb2c041d8028740440937705ebb473a", "sha256": "fb53f8539e7fcb8f093a56e138112056ec1dc809ebb020b59d8a36a5ebac37e0", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3.jar", "source": {"sha1": "cfd5385e0c5ed1c8a5dce57d86e79cf357153a64", "sha256": "480cb5e99519271c9256716d4be1a27054047435ff72078d9deae5c6a19f63eb", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3-sources.jar"} , "name": "ch_qos_logback_logback_classic", "actual": "@ch_qos_logback_logback_classic//jar", "bind": "jar/ch/qos/logback/logback_classic"},
    {"artifact": "ch.qos.logback:logback-core:1.2.3", "lang": "java", "sha1": "864344400c3d4d92dfeb0a305dc87d953677c03c", "sha256": "5946d837fe6f960c02a53eda7a6926ecc3c758bbdd69aa453ee429f858217f22", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/ch/qos/logback/logback-core/1.2.3/logback-core-1.2.3.jar", "source": {"sha1": "3ebabe69eba0196af9ad3a814f723fb720b9101e", "sha256": "1f69b6b638ec551d26b10feeade5a2b77abe347f9759da95022f0da9a63a9971", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/ch/qos/logback/logback-core/1.2.3/logback-core-1.2.3-sources.jar"} , "name": "ch_qos_logback_logback_core", "actual": "@ch_qos_logback_logback_core//jar", "bind": "jar/ch/qos/logback/logback_core"},
    {"artifact": "com.github.nscala-time:nscala-time_2.12:2.14.0", "lang": "scala", "sha1": "ef88ed2ebd7e64853cea317cd916dac201154e4e", "sha256": "34975bd1d34a746bc9c5fc0b0b953bffbba255392f42ab1247e488eacadb64a6", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/nscala-time/nscala-time_2.12/2.14.0/nscala-time_2.12-2.14.0.jar", "source": {"sha1": "fd0cf17a53855e7935055b23694d240aa38dc2cd", "sha256": "d892a90c02c12ff60c090ffcc56080540f6735699c3363b3d3eac01dbe48527c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/nscala-time/nscala-time_2.12/2.14.0/nscala-time_2.12-2.14.0-sources.jar"} , "name": "com_github_nscala_time_nscala_time_2_12", "actual": "@com_github_nscala_time_nscala_time_2_12//jar:file", "bind": "jar/com/github/nscala_time/nscala_time_2_12"},
    {"artifact": "com.github.scopt:scopt_2.12:3.7.0", "lang": "scala", "sha1": "e078455e1a65597146f8608dab3247bf1eb92e6e", "sha256": "1105ff2819f267e06b9a84843231a9fd7a69817c49e5d67167cb601e47ce2c56", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/scopt/scopt_2.12/3.7.0/scopt_2.12-3.7.0.jar", "source": {"sha1": "c560830a3061abd37463de2ac0560a4825ace566", "sha256": "5d642a8f96c9e0243d15badd519ffb2a7f2786ce70d5e5c21003bb9b70ff507d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/scopt/scopt_2.12/3.7.0/scopt_2.12-3.7.0-sources.jar"} , "name": "com_github_scopt_scopt_2_12", "actual": "@com_github_scopt_scopt_2_12//jar:file", "bind": "jar/com/github/scopt/scopt_2_12"},
    {"artifact": "com.thoughtworks.paranamer:paranamer:2.8", "lang": "java", "sha1": "619eba74c19ccf1da8ebec97a2d7f8ba05773dd6", "sha256": "688cb118a6021d819138e855208c956031688be4b47a24bb615becc63acedf07", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/thoughtworks/paranamer/paranamer/2.8/paranamer-2.8.jar", "source": {"sha1": "8f3421a8203053a6ab4b74f76a0550d21eee8cfe", "sha256": "8a4bfc21755c36ccdd70f96d7ab891d842d5aebd6afa1b74e0efc6441e3df39c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/thoughtworks/paranamer/paranamer/2.8/paranamer-2.8-sources.jar"} , "name": "com_thoughtworks_paranamer_paranamer", "actual": "@com_thoughtworks_paranamer_paranamer//jar", "bind": "jar/com/thoughtworks/paranamer/paranamer"},
    {"artifact": "com.typesafe.scala-logging:scala-logging_2.12:3.9.0", "lang": "scala", "sha1": "b6c6bb584f3e5c2d3f20aa7c8ff3e6959870b13c", "sha256": "58073c9891e26b99a12c1b501754d8447897913e023fdd37765b58e6377408bc", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/scala-logging/scala-logging_2.12/3.9.0/scala-logging_2.12-3.9.0.jar", "source": {"sha1": "91387647fa19f1db2adf8c3aee8a3c0dee5d7aa7", "sha256": "91dfdbe8217415b22fdca6df172fd00ade87768061b4115cf97719316ebb3720", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/scala-logging/scala-logging_2.12/3.9.0/scala-logging_2.12-3.9.0-sources.jar"} , "name": "com_typesafe_scala_logging_scala_logging_2_12", "actual": "@com_typesafe_scala_logging_scala_logging_2_12//jar:file", "bind": "jar/com/typesafe/scala_logging/scala_logging_2_12"},
    {"artifact": "joda-time:joda-time:2.9.4", "lang": "java", "sha1": "1c295b462f16702ebe720bbb08f62e1ba80da41b", "sha256": "deef06d5ead0b3f940bf6fd8aba4aea0d5857213a199874d1f7a8e6a6538d133", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/joda-time/joda-time/2.9.4/joda-time-2.9.4.jar", "source": {"sha1": "53c1bcc94f55a63bed4715f766d5d5f5c411bc33", "sha256": "b8a7a2575e8b8d30d4a5a53e2480d424ddb97fcca1582bd779f55744c9e7b5dc", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/joda-time/joda-time/2.9.4/joda-time-2.9.4-sources.jar"} , "name": "joda_time_joda_time", "actual": "@joda_time_joda_time//jar", "bind": "jar/joda_time/joda_time"},
    {"artifact": "net.jcazevedo:moultingyaml_2.12:0.4.0", "lang": "scala", "sha1": "2e6c3eae76741ac2a155898b7caeb5b912fc8187", "sha256": "69918ec6da46452e80aabe27598d6fb75154204841b8d1c5d030b59bd2f9e9fd", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/jcazevedo/moultingyaml_2.12/0.4.0/moultingyaml_2.12-0.4.0.jar", "source": {"sha1": "b044a0eeab7872791efdc178ea5cfabbf27e2254", "sha256": "ce03db6128281237d892ea65cb205827e687e14cba740379faf24a485c9e9934", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/jcazevedo/moultingyaml_2.12/0.4.0/moultingyaml_2.12-0.4.0-sources.jar"} , "name": "net_jcazevedo_moultingyaml_2_12", "actual": "@net_jcazevedo_moultingyaml_2_12//jar:file", "bind": "jar/net/jcazevedo/moultingyaml_2_12"},
    {"artifact": "org.joda:joda-convert:1.2", "lang": "java", "sha1": "35ec554f0cd00c956cc69051514d9488b1374dec", "sha256": "5703e1a2ac1969fe90f87076c1f1136822bf31d8948252159c86e6d0535c81a8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/joda/joda-convert/1.2/joda-convert-1.2.jar", "source": {"sha1": "f3daaa17839418e4f066d492079d1365f61b5250", "sha256": "d51f322eb0a819480bb75d5f41263c5158e05a0ac78aa3a132edadd6763192ca", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/joda/joda-convert/1.2/joda-convert-1.2-sources.jar"} , "name": "org_joda_joda_convert", "actual": "@org_joda_joda_convert//jar", "bind": "jar/org/joda/joda_convert"},
    {"artifact": "org.json4s:json4s-ast_2.12:3.6.1", "lang": "scala", "sha1": "cf937592788dfa654acb9679b97eb1e691bf69f8", "sha256": "39c7de601df28e32eb0c4e3d684ec65bbf2e59af83c6088cda12688d796f7746", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/json4s/json4s-ast_2.12/3.6.1/json4s-ast_2.12-3.6.1.jar", "source": {"sha1": "b612351c35c1afbb8185ba454c03fc62378a6da1", "sha256": "b0c547f81578c04b9f8b036ecffacbeb43aa863b17127d3e133c84a865c3ddb9", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/json4s/json4s-ast_2.12/3.6.1/json4s-ast_2.12-3.6.1-sources.jar"} , "name": "org_json4s_json4s_ast_2_12", "actual": "@org_json4s_json4s_ast_2_12//jar:file", "bind": "jar/org/json4s/json4s_ast_2_12"},
    {"artifact": "org.json4s:json4s-core_2.12:3.6.1", "lang": "scala", "sha1": "7a619365089281c6015b80c499ff3b3cb196572f", "sha256": "e0f481509429a24e295b30ba64f567bad95e8d978d0882ec74e6dab291fcdac0", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/json4s/json4s-core_2.12/3.6.1/json4s-core_2.12-3.6.1.jar", "source": {"sha1": "22dd86d5e2cb25c8e6f3ef19aa8085a56bfba5a7", "sha256": "cc53a738421b22f7e33e14354a5582086281756a9576bde219ee4d4976d4dfbc", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/json4s/json4s-core_2.12/3.6.1/json4s-core_2.12-3.6.1-sources.jar"} , "name": "org_json4s_json4s_core_2_12", "actual": "@org_json4s_json4s_core_2_12//jar:file", "bind": "jar/org/json4s/json4s_core_2_12"},
    {"artifact": "org.json4s:json4s-native_2.12:3.6.1", "lang": "scala", "sha1": "3d1d666321c82a245e7efd14299dc410f6f94182", "sha256": "6a476bdab820617d06a73b539266ab2c2bd702049baac24f447b0d1b1679737e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/json4s/json4s-native_2.12/3.6.1/json4s-native_2.12-3.6.1.jar", "source": {"sha1": "20c67ae90504dadc83412ce33906a16ccd79cab8", "sha256": "030fb04d9f371ca4313a15256acc80468a03c180f0924f7dd0e85bfae4fef68e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/json4s/json4s-native_2.12/3.6.1/json4s-native_2.12-3.6.1-sources.jar"} , "name": "org_json4s_json4s_native_2_12", "actual": "@org_json4s_json4s_native_2_12//jar:file", "bind": "jar/org/json4s/json4s_native_2_12"},
    {"artifact": "org.json4s:json4s-scalap_2.12:3.6.1", "lang": "scala", "sha1": "6adce67bf3ad41a441a18d1385269966b7a0922b", "sha256": "0c34f6797c76c7709c44eef4b59a69b36e2c13acfeebc5a5b70fb2f6446acec5", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/json4s/json4s-scalap_2.12/3.6.1/json4s-scalap_2.12-3.6.1.jar", "source": {"sha1": "e6e290e8744dcb28c4edae267961e338f185355b", "sha256": "dea47eb095642e457dbd2b8bc66b2c63f8e05eb5d59b55d9464ddae4b1793e83", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/json4s/json4s-scalap_2.12/3.6.1/json4s-scalap_2.12-3.6.1-sources.jar"} , "name": "org_json4s_json4s_scalap_2_12", "actual": "@org_json4s_json4s_scalap_2_12//jar:file", "bind": "jar/org/json4s/json4s_scalap_2_12"},
    {"artifact": "org.scala-lang.modules:scala-xml_2.12:1.0.6", "lang": "scala", "sha1": "e22de3366a698a9f744106fb6dda4335838cf6a7", "sha256": "7cc3b6ceb56e879cb977e8e043f4bfe2e062f78795efd7efa09f85003cb3230a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/modules/scala-xml_2.12/1.0.6/scala-xml_2.12-1.0.6.jar", "source": {"sha1": "429925530fb0f9a6fb26e5160532b7b3426557c0", "sha256": "a7e8aac79394df396afda98b35537791809d815ce15ab2224f7d31e50c753922", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/modules/scala-xml_2.12/1.0.6/scala-xml_2.12-1.0.6-sources.jar"} , "name": "org_scala_lang_modules_scala_xml_2_12", "actual": "@org_scala_lang_modules_scala_xml_2_12//jar:file", "bind": "jar/org/scala_lang/modules/scala_xml_2_12"},
    {"artifact": "org.scala-sbt:test-interface:1.0", "lang": "java", "sha1": "0a3f14d010c4cb32071f863d97291df31603b521", "sha256": "15f70b38bb95f3002fec9aea54030f19bb4ecfbad64c67424b5e5fea09cd749e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-sbt/test-interface/1.0/test-interface-1.0.jar", "source": {"sha1": "d44b23e9e3419ad0e00b91bba764a48d43075000", "sha256": "c314491c9df4f0bd9dd125ef1d51228d70bd466ee57848df1cd1b96aea18a5ad", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-sbt/test-interface/1.0/test-interface-1.0-sources.jar"} , "name": "org_scala_sbt_test_interface", "actual": "@org_scala_sbt_test_interface//jar", "bind": "jar/org/scala_sbt/test_interface"},
    {"artifact": "org.scalacheck:scalacheck_2.12:1.14.0", "lang": "scala", "sha1": "8b4354c1a5e1799b4b0ab888d326e7f7fdb02d0d", "sha256": "1e6f5b292bb74b03be74195047816632b7d95e40e7f9c13d5d2c53bafeece62e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalacheck/scalacheck_2.12/1.14.0/scalacheck_2.12-1.14.0.jar", "source": {"sha1": "ee64746db17b19449fae7e4b9f9ffc8fb7e79d80", "sha256": "6d51786f6ed8241bc02ea90bdd769ef16f2cc034624e06877de1d4a735efcb7f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalacheck/scalacheck_2.12/1.14.0/scalacheck_2.12-1.14.0-sources.jar"} , "name": "org_scalacheck_scalacheck_2_12", "actual": "@org_scalacheck_scalacheck_2_12//jar:file", "bind": "jar/org/scalacheck/scalacheck_2_12"},
    {"artifact": "org.scalactic:scalactic_2.12:3.0.5", "lang": "scala", "sha1": "edec43902cdc7c753001501e0d8c2de78394fb03", "sha256": "57e25b4fd969b1758fe042595112c874dfea99dca5cc48eebe07ac38772a0c41", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalactic/scalactic_2.12/3.0.5/scalactic_2.12-3.0.5.jar", "source": {"sha1": "e02d37e95ba74c95aa9063b9114db51f2810b212", "sha256": "0455eaecaa2b8ce0be537120c2ccd407c4606cbe53e63cb6a7fc8b31b5b65461", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalactic/scalactic_2.12/3.0.5/scalactic_2.12-3.0.5-sources.jar"} , "name": "org_scalactic_scalactic_2_12", "actual": "@org_scalactic_scalactic_2_12//jar:file", "bind": "jar/org/scalactic/scalactic_2_12"},
    {"artifact": "org.scalatest:scalatest_2.12:3.0.5", "lang": "scala", "sha1": "7bb56c0f7a3c60c465e36c6b8022a95b883d7434", "sha256": "b416b5bcef6720da469a8d8a5726e457fc2d1cd5d316e1bc283aa75a2ae005e5", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest_2.12/3.0.5/scalatest_2.12-3.0.5.jar", "source": {"sha1": "ec414035204524d3d4205ef572075e34a2078c78", "sha256": "22081ee83810098adc9af4d84d05dd5891d7c0e15f9095bcdaf4ac7a228b92df", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest_2.12/3.0.5/scalatest_2.12-3.0.5-sources.jar"} , "name": "org_scalatest_scalatest_2_12", "actual": "@org_scalatest_scalatest_2_12//jar:file", "bind": "jar/org/scalatest/scalatest_2_12"},
    {"artifact": "org.slf4j:slf4j-api:1.7.25", "lang": "java", "sha1": "da76ca59f6a57ee3102f8f9bd9cee742973efa8a", "sha256": "18c4a0095d5c1da6b817592e767bb23d29dd2f560ad74df75ff3961dbde25b79", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25.jar", "source": {"sha1": "962153db4a9ea71b79d047dfd1b2a0d80d8f4739", "sha256": "c4bc93180a4f0aceec3b057a2514abe04a79f06c174bbed910a2afb227b79366", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25-sources.jar"} , "name": "org_slf4j_slf4j_api", "actual": "@org_slf4j_slf4j_api//jar", "bind": "jar/org/slf4j/slf4j_api"},
    {"artifact": "org.yaml:snakeyaml:1.17", "lang": "java", "sha1": "7a27ea250c5130b2922b86dea63cbb1cc10a660c", "sha256": "5666b36f9db46f06dd5a19d73bbff3b588d5969c0f4b8848fde0f5ec849430a5", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/yaml/snakeyaml/1.17/snakeyaml-1.17.jar", "source": {"sha1": "63577e87886c76228db9f8a2c50ea43cde5072eb", "sha256": "79a31334ef1fa68202dbd36632e259528e9212f65a805d383417080130fb9dc9", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/yaml/snakeyaml/1.17/snakeyaml-1.17-sources.jar"} , "name": "org_yaml_snakeyaml", "actual": "@org_yaml_snakeyaml//jar", "bind": "jar/org/yaml/snakeyaml"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
