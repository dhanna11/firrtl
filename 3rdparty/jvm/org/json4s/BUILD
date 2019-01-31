load("@io_bazel_rules_scala//scala:scala_import.bzl", "scala_import")
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library")
scala_import(
    name = "json4s_ast",
    exports = [
        "//3rdparty/jvm/org/scala_lang:scala_library"
    ],
    jars = [
        "//external:jar/org/json4s/json4s_ast_2_12"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)



scala_import(
    name = "json4s_core",
    exports = [
        "//3rdparty/jvm/com/thoughtworks/paranamer:paranamer",
        "//3rdparty/jvm/org/scala_lang:scala_library",
        ":json4s_ast",
        ":json4s_scalap"
    ],
    jars = [
        "//external:jar/org/json4s/json4s_core_2_12"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)



scala_import(
    name = "json4s_native",
    exports = [
        "//3rdparty/jvm/org/scala_lang:scala_library",
        ":json4s_core"
    ],
    jars = [
        "//external:jar/org/json4s/json4s_native_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



scala_import(
    name = "json4s_scalap",
    exports = [
        "//3rdparty/jvm/org/scala_lang:scala_library"
    ],
    jars = [
        "//external:jar/org/json4s/json4s_scalap_2_12"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)


