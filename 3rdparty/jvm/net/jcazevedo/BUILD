load("@io_bazel_rules_scala//scala:scala_import.bzl", "scala_import")
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library")
scala_import(
    name = "moultingyaml",
    exports = [
        "//3rdparty/jvm/com/github/nscala_time:nscala_time",
        "//3rdparty/jvm/org/scala_lang:scala_library",
        "//3rdparty/jvm/org/scala_lang:scala_reflect",
        "//3rdparty/jvm/org/yaml:snakeyaml"
    ],
    jars = [
        "//external:jar/net/jcazevedo/moultingyaml_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)


