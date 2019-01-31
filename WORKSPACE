load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_antlr",
    strip_prefix = "rules_antlr-d7b678217ac1ac63a86752c52e211af2771d97fc",
    urls = ["https://github.com/marcohu/rules_antlr/archive/d7b678217ac1ac63a86752c52e211af2771d97fc.zip"],
)

load("@rules_antlr//antlr:deps.bzl", "antlr_dependencies")

antlr_dependencies(4)

rules_scala_version = "a89d44f7ef67d93dedfc9888630f48d7723516f7"  # update this as needed

http_archive(
    name = "io_bazel_rules_scala",
    strip_prefix = "rules_scala-%s" % rules_scala_version,
    type = "zip",
    url = "https://github.com/bazelbuild/rules_scala/archive/%s.zip" % rules_scala_version,
)

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")

scala_repositories()

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")

scala_register_toolchains()

load("//3rdparty:workspace.bzl", "maven_dependencies")

maven_dependencies()

http_archive(
    name = "com_google_protobuf",
    sha256 = "cef7f1b5a7c5fba672bec2a319246e8feba471f04dcebfe362d55930ee7c1c30",
    strip_prefix = "protobuf-3.5.0",
    urls = ["https://github.com/google/protobuf/archive/v3.5.0.zip"],
)
