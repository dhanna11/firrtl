load("@io_bazel_rules_scala//scala:scala_import.bzl", "scala_import")
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library")
scala_import(
    name = "scala_logging",
    exports = [
        "//3rdparty/jvm/org/scala_lang:scala_library",
        "//3rdparty/jvm/org/scala_lang:scala_reflect",
        "//3rdparty/jvm/org/slf4j:slf4j_api"
    ],
    jars = [
        "//external:jar/com/typesafe/scala_logging/scala_logging_2_11"
    ],
    visibility = [
        "//visibility:public"
    ]
)



scala_import(
    name = "scala_logging_api",
    exports = [
        "//3rdparty/jvm/org/scala_lang:scala_library"
    ],
    jars = [
        "//external:jar/com/typesafe/scala_logging/scala_logging_api_2_11"
    ],
    visibility = [
        "//visibility:public"
    ]
)



scala_import(
    name = "scala_logging_slf4j",
    exports = [
        "//3rdparty/jvm/org/scala_lang:scala_library",
        "//3rdparty/jvm/org/scala_lang:scala_reflect",
        "//3rdparty/jvm/org/slf4j:slf4j_api",
        ":scala_logging_api"
    ],
    jars = [
        "//external:jar/com/typesafe/scala_logging/scala_logging_slf4j_2_11"
    ],
    visibility = [
        "//visibility:public"
    ]
)


