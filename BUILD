package(default_visibility = ["//visibility:public"])

load("@rules_antlr//antlr:antlr4.bzl", "antlr4")
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_binary", "scala_library")

antlr4(
    name = "firrtl_antr4_srcs",
    srcs = ["src/main/antlr4/FIRRTL.g4"],
    no_listener = False,
    package = "firrtl.antlr",
    visitor = True,
    deps = [
        "//src/main/java:LexerHelper",
        "@antlr3_runtime//jar",
        "@antlr4_runtime//jar",
        "@antlr4_tool//jar",
        "@javax_json//jar",
        "@stringtemplate4//jar",
    ],
)

java_library(
    name = "firrtl_antlr4_java_lib",
    srcs = [":firrtl_antr4_srcs"],
    deps = [
        "//src/main/java:LexerHelper",
        "@antlr4_runtime//jar",
    ],
)

scala_library(
    name = "firrtl_lib",
    srcs = glob(["src/main/scala/**/*.scala"]),
    scalac_jvm_flags = ["-Xss2M"],
    deps = [
        ":firrtl_antlr4_java_lib",
        ":firrtl_java_proto",
        "//3rdparty/jvm/ch/qos/logback:logback_classic",
        "//3rdparty/jvm/com/github/scopt",
        "//3rdparty/jvm/com/typesafe/scala_logging",
        "//3rdparty/jvm/net/jcazevedo:moultingyaml",
        "//3rdparty/jvm/org/json4s:json4s_native",
        "//3rdparty/jvm/org/scalacheck",
        "//3rdparty/jvm/org/scalatest",
        "@antlr4_runtime//jar",
        "@com_google_protobuf//:protobuf_java",
    ],
)

scala_binary(
    name = "firrtl_bin",
    data = ["src/main/resources/logback.xml"],
    main_class = "firrtl.Driver",
    deps = [":firrtl_lib"],
)

proto_library(
    name = "firrtl_proto",
    srcs = ["src/main/proto/firrtl.proto"],
)

java_proto_library(
    name = "firrtl_java_proto",
    deps = [":firrtl_proto"],
)
