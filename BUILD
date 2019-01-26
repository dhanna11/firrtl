package(default_visibility = ["//visibility:public"])

load("@rules_antlr//antlr:antlr4.bzl", "antlr4")
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library", "scala_binary", "scala_macro_library", "scala_test")

antlr4(
    name = "generated",
    srcs = ["src/main/antlr4/FIRRTL.g4"],
    package = "firrtl.antlr",
    no_listener = False,
    visitor = True,
)

java_library(
    name = "firrtlparserlib",
    srcs = [":generated"],
    deps = ["@antlr4_runtime//jar"],
)

scala_library(
    name = "firrtllib",
    srcs = glob(["src/main/scala/**/*.scala"]),
    deps = [
    ":firrtlparserlib",
    "//3rdparty/jvm/org/slf4j:slf4j_api",
    "//3rdparty/jvm/com/typesafe/scala_logging:scala_logging",
    "//3rdparty/jvm/ch/qos/logback:logback_classic",
    "//3rdparty/jvm/org/scalatest",
    "//3rdparty/jvm/org/scalacheck",
    "@antlr4_runtime//jar",
    ],
    scalac_jvm_flags = ["-Xss2M",]

)

scala_binary(
    name = "firrtl_bin",
    deps = [":firrtllib",],
    main_class = "firrtl.Driver",
    data = ["src/main/resources/logback.xml"],
)