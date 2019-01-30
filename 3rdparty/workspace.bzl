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
    {"artifact": "ch.qos.logback:logback-classic:1.1.2", "lang": "java", "sha1": "b316e9737eea25e9ddd6d88eaeee76878045c6b2", "sha256": "30b792e2745752fad8e1f92ca750d5f2d480edd2c5e99bc098aaebe22eb48c22", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/ch/qos/logback/logback-classic/1.1.2/logback-classic-1.1.2.jar", "source": {"sha1": "decd76e2c461157804473468bbdc6b8eb6d6121b", "sha256": "24c37a20900cd61ac6917b8b98a7730b3ea5d19e1e8e2476351fbd5f32302f75", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/ch/qos/logback/logback-classic/1.1.2/logback-classic-1.1.2-sources.jar"} , "name": "ch_qos_logback_logback_classic", "actual": "@ch_qos_logback_logback_classic//jar", "bind": "jar/ch/qos/logback/logback_classic"},
    {"artifact": "ch.qos.logback:logback-core:1.1.2", "lang": "java", "sha1": "2d23694879c2c12f125dac5076bdfd5d771cc4cb", "sha256": "90f1dfca25cd776f28a589f58b181d0e6787668a1b1fa8510bead402f86edcb1", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/ch/qos/logback/logback-core/1.1.2/logback-core-1.1.2.jar", "source": {"sha1": "502e1c764542fe747896c1dc04f023acfe0e5cbc", "sha256": "c418fd22e67e8df7634b94b2f79ce36f810023cd5e268dcf08f4a2e3f759609d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/ch/qos/logback/logback-core/1.1.2/logback-core-1.1.2-sources.jar"} , "name": "ch_qos_logback_logback_core", "actual": "@ch_qos_logback_logback_core//jar", "bind": "jar/ch/qos/logback/logback_core"},
    {"artifact": "com.github.nscala-time:nscala-time_2.11:2.2.0", "lang": "scala", "sha1": "d4efa7d48fb585c651f828d73f23fcd1130c4114", "sha256": "4ef32f7d092727d32766c8329f7eecd1cc32b4354422815857ef2842fa942ec2", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/nscala-time/nscala-time_2.11/2.2.0/nscala-time_2.11-2.2.0.jar", "source": {"sha1": "36a4c7d733307584446404c6f90d3df195a19ee2", "sha256": "5d6f9d3b1862bd3def5929d02e28d14e761450e6aacfc1b111e4266649c02a37", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/nscala-time/nscala-time_2.11/2.2.0/nscala-time_2.11-2.2.0-sources.jar"} , "name": "com_github_nscala_time_nscala_time_2_11", "actual": "@com_github_nscala_time_nscala_time_2_11//jar:file", "bind": "jar/com/github/nscala_time/nscala_time_2_11"},
    {"artifact": "com.typesafe.scala-logging:scala-logging-api_2.11:2.1.2", "lang": "scala", "sha1": "fed5521041c26b8c1daa2d5e5dc5f01b9bde4fe6", "sha256": "d72a4c7e0b79abba00b7c5b223349a9fb57d06990796c9467debefd02728e572", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/scala-logging/scala-logging-api_2.11/2.1.2/scala-logging-api_2.11-2.1.2.jar", "source": {"sha1": "2760b35266ddb0dc88f48a999e1a772af16f35f9", "sha256": "a3ab61261cf4cf8237a9b621d1047eddd704dec1c9f37a7c2883134c68b186bc", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/scala-logging/scala-logging-api_2.11/2.1.2/scala-logging-api_2.11-2.1.2-sources.jar"} , "name": "com_typesafe_scala_logging_scala_logging_api_2_11", "actual": "@com_typesafe_scala_logging_scala_logging_api_2_11//jar:file", "bind": "jar/com/typesafe/scala_logging/scala_logging_api_2_11"},
    {"artifact": "com.typesafe.scala-logging:scala-logging-slf4j_2.11:2.1.2", "lang": "scala", "sha1": "7628485be79eacac9e7f19bf049f581394d45ea3", "sha256": "e6e96a55a850397d2fcb7fd24375367631b04a4e3732ef3549f2bd73c6a9302b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/scala-logging/scala-logging-slf4j_2.11/2.1.2/scala-logging-slf4j_2.11-2.1.2.jar", "source": {"sha1": "ef510f1f80be5f34a32888151c2adf35fde1f9d1", "sha256": "33649fe42bf77b56ced00264e4d881e47a49ac7a56449d1e8f2352a38eccddb8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/scala-logging/scala-logging-slf4j_2.11/2.1.2/scala-logging-slf4j_2.11-2.1.2-sources.jar"} , "name": "com_typesafe_scala_logging_scala_logging_slf4j_2_11", "actual": "@com_typesafe_scala_logging_scala_logging_slf4j_2_11//jar:file", "bind": "jar/com/typesafe/scala_logging/scala_logging_slf4j_2_11"},
    {"artifact": "com.typesafe.scala-logging:scala-logging_2.11:3.1.0", "lang": "scala", "sha1": "134d96ef46da35dbab455eb223255cf31d834a33", "sha256": "375b884a80b9c0d6f54fd8fbfe1419df16f6ed3779516fe4e64932d74384ed98", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/scala-logging/scala-logging_2.11/3.1.0/scala-logging_2.11-3.1.0.jar", "source": {"sha1": "77fc4aedf282d929c95bbb9ad2b8f904a7249eed", "sha256": "a39b65f382fb23efd91dc00db4689e89987c0bd600423e007b4b8802107a09ef", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/scala-logging/scala-logging_2.11/3.1.0/scala-logging_2.11-3.1.0-sources.jar"} , "name": "com_typesafe_scala_logging_scala_logging_2_11", "actual": "@com_typesafe_scala_logging_scala_logging_2_11//jar:file", "bind": "jar/com/typesafe/scala_logging/scala_logging_2_11"},
    {"artifact": "joda-time:joda-time:2.8.2", "lang": "java", "sha1": "d27c24204c5e507b16fec01006b3d0f1ec42aed4", "sha256": "7c71ac7b4c0e6b7e49bcc93c135825d23f427aba62397b313c7fdcd2c19c42cb", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/joda-time/joda-time/2.8.2/joda-time-2.8.2.jar", "source": {"sha1": "65dd2b998571ea61a3cee68c99a1dde729b14a7e", "sha256": "a43afadbb32c0d31b1d9b3ad70c6603224c7fd14aa0e657853a70e533ab1f878", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/joda-time/joda-time/2.8.2/joda-time-2.8.2-sources.jar"} , "name": "joda_time_joda_time", "actual": "@joda_time_joda_time//jar", "bind": "jar/joda_time/joda_time"},
    {"artifact": "net.jcazevedo:moultingyaml_2.11:0.2", "lang": "scala", "sha1": "4d8dfd0e37fd78b1ee123959c9701a03f7e7d04c", "sha256": "f2de72f39ea2fac8ab660f7562b5eaeb2e30d9975201ef5e2d2daa2199db3791", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/jcazevedo/moultingyaml_2.11/0.2/moultingyaml_2.11-0.2.jar", "source": {"sha1": "9628bf55c7af044b99b00fb761fcdbce9f70ea5e", "sha256": "19ec2deaf855fd722269ebf7146a728448bb1d05eadc10bea70606797a9d0052", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/jcazevedo/moultingyaml_2.11/0.2/moultingyaml_2.11-0.2-sources.jar"} , "name": "net_jcazevedo_moultingyaml_2_11", "actual": "@net_jcazevedo_moultingyaml_2_11//jar:file", "bind": "jar/net/jcazevedo/moultingyaml_2_11"},
    {"artifact": "org.joda:joda-convert:1.2", "lang": "java", "sha1": "35ec554f0cd00c956cc69051514d9488b1374dec", "sha256": "5703e1a2ac1969fe90f87076c1f1136822bf31d8948252159c86e6d0535c81a8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/joda/joda-convert/1.2/joda-convert-1.2.jar", "source": {"sha1": "f3daaa17839418e4f066d492079d1365f61b5250", "sha256": "d51f322eb0a819480bb75d5f41263c5158e05a0ac78aa3a132edadd6763192ca", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/joda/joda-convert/1.2/joda-convert-1.2-sources.jar"} , "name": "org_joda_joda_convert", "actual": "@org_joda_joda_convert//jar", "bind": "jar/org/joda/joda_convert"},
    {"artifact": "org.scala-lang.modules:scala-xml_2.11:1.0.2", "lang": "scala", "sha1": "820fbca7e524b530fdadc594c39d49a21ea0337e", "sha256": "13c0d8d442bde14b73af3ed60e8d53452f9e1ad62ffbe3d944cb918df652db6f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/modules/scala-xml_2.11/1.0.2/scala-xml_2.11-1.0.2.jar", "source": {"sha1": "312c3557d1ca0b34820f3b3fc5404a47936ceb26", "sha256": "c3c8d5f1f7b198a3d7df137eb9f52530a2222ccac24411a72a734980bb37595a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/modules/scala-xml_2.11/1.0.2/scala-xml_2.11-1.0.2-sources.jar"} , "name": "org_scala_lang_modules_scala_xml_2_11", "actual": "@org_scala_lang_modules_scala_xml_2_11//jar:file", "bind": "jar/org/scala_lang/modules/scala_xml_2_11"},
    {"artifact": "org.scala-sbt:test-interface:1.0", "lang": "java", "sha1": "0a3f14d010c4cb32071f863d97291df31603b521", "sha256": "15f70b38bb95f3002fec9aea54030f19bb4ecfbad64c67424b5e5fea09cd749e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-sbt/test-interface/1.0/test-interface-1.0.jar", "source": {"sha1": "d44b23e9e3419ad0e00b91bba764a48d43075000", "sha256": "c314491c9df4f0bd9dd125ef1d51228d70bd466ee57848df1cd1b96aea18a5ad", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-sbt/test-interface/1.0/test-interface-1.0-sources.jar"} , "name": "org_scala_sbt_test_interface", "actual": "@org_scala_sbt_test_interface//jar", "bind": "jar/org/scala_sbt/test_interface"},
    {"artifact": "org.scalacheck:scalacheck_2.11:1.12.5", "lang": "scala", "sha1": "dc2f59c89d01dc115172a1caeb35db178301147c", "sha256": "d34458713895d2d72c4893311bacef63b44f37f7a3e91f225d0e002406c97c65", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalacheck/scalacheck_2.11/1.12.5/scalacheck_2.11-1.12.5.jar", "source": {"sha1": "9fe10d021cfad8ca3259ff495f6cb51c06a5fe91", "sha256": "21bdabd42cefcad12ed3683c727082ea199cf4e8ed9664cacd99400adafc2c19", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalacheck/scalacheck_2.11/1.12.5/scalacheck_2.11-1.12.5-sources.jar"} , "name": "org_scalacheck_scalacheck_2_11", "actual": "@org_scalacheck_scalacheck_2_11//jar:file", "bind": "jar/org/scalacheck/scalacheck_2_11"},
    {"artifact": "org.scalatest:scalatest_2.11:2.2.6", "lang": "scala", "sha1": "80cd969b5f678cd90017498d865e63d7f6e79696", "sha256": "f198967436a5e7a69cfd182902adcfbcb9f2e41b349e1a5c8881a2407f615962", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest_2.11/2.2.6/scalatest_2.11-2.2.6.jar", "source": {"sha1": "d6a84266c1649cec301332be09c5c0493d1e54d9", "sha256": "3fbb4d0c52b594a8763275e60a24873afc0a6d13508082f5538469d273f6dddf", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest_2.11/2.2.6/scalatest_2.11-2.2.6-sources.jar"} , "name": "org_scalatest_scalatest_2_11", "actual": "@org_scalatest_scalatest_2_11//jar:file", "bind": "jar/org/scalatest/scalatest_2_11"},
# duplicates in org.slf4j:slf4j-api fixed to 1.7.25
# - ch.qos.logback:logback-classic:1.1.2 wanted version 1.7.6
# - com.typesafe.scala-logging:scala-logging-slf4j_2.11:2.1.2 wanted version 1.7.7
# - com.typesafe.scala-logging:scala-logging_2.11:3.1.0 wanted version 1.7.7
# - org.slf4j:slf4j-simple:1.7.25 wanted version 1.7.25
    {"artifact": "org.slf4j:slf4j-api:1.7.25", "lang": "java", "sha1": "da76ca59f6a57ee3102f8f9bd9cee742973efa8a", "sha256": "18c4a0095d5c1da6b817592e767bb23d29dd2f560ad74df75ff3961dbde25b79", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25.jar", "source": {"sha1": "962153db4a9ea71b79d047dfd1b2a0d80d8f4739", "sha256": "c4bc93180a4f0aceec3b057a2514abe04a79f06c174bbed910a2afb227b79366", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25-sources.jar"} , "name": "org_slf4j_slf4j_api", "actual": "@org_slf4j_slf4j_api//jar", "bind": "jar/org/slf4j/slf4j_api"},
    {"artifact": "org.slf4j:slf4j-simple:1.7.25", "lang": "java", "sha1": "8dacf9514f0c707cbbcdd6fd699e8940d42fb54e", "sha256": "0966e86fffa5be52d3d9e7b89dd674d98a03eed0a454fbaf7c1bd9493bd9d874", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/slf4j-simple/1.7.25/slf4j-simple-1.7.25.jar", "source": {"sha1": "af3cd3ad1ea4b08b27b54f12529b4bf343bc5ca1", "sha256": "2cfa254e77c6f41bdcd8500c61c0f6b9959de66835d2b598102d38c2a807f367", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/slf4j-simple/1.7.25/slf4j-simple-1.7.25-sources.jar"} , "name": "org_slf4j_slf4j_simple", "actual": "@org_slf4j_slf4j_simple//jar", "bind": "jar/org/slf4j/slf4j_simple"},
    {"artifact": "org.yaml:snakeyaml:1.16", "lang": "java", "sha1": "d64fb662c9e42789149f5078a62a22edda786c6a", "sha256": "c1baa1c7419f2cfe2f4dd8550fcb7906694abcfe7b616571f5a43af9cf187d4a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/yaml/snakeyaml/1.16/snakeyaml-1.16.jar", "source": {"sha1": "ad03b39efb3749be4c8d2eae23d6dee72c889f3b", "sha256": "e6a4324a7bdcf6839d9e37eebdbde6edd65d460d43044b204c5936db3df2ed18", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/yaml/snakeyaml/1.16/snakeyaml-1.16-sources.jar"} , "name": "org_yaml_snakeyaml", "actual": "@org_yaml_snakeyaml//jar", "bind": "jar/org/yaml/snakeyaml"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
