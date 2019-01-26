load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_antlr",
    strip_prefix = "rules_antlr-d7b678217ac1ac63a86752c52e211af2771d97fc",
    urls = ["https://github.com/marcohu/rules_antlr/archive/d7b678217ac1ac63a86752c52e211af2771d97fc.zip"],
)

load("@rules_antlr//antlr:deps.bzl", "antlr_dependencies")
antlr_dependencies(4)

rules_scala_version="a89d44f7ef67d93dedfc9888630f48d7723516f7" # update this as needed

http_archive(
             name = "io_bazel_rules_scala",
             url = "https://github.com/bazelbuild/rules_scala/archive/%s.zip"%rules_scala_version,
             type = "zip",
             strip_prefix= "rules_scala-%s" % rules_scala_version
             )

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")
scala_repositories()

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
scala_register_toolchains()

http_archive(
    name = "bazel-deps",
    strip_prefix = "bazel_deps-3fdaaa6de3ed8cf010a6b1713a04d55c4abb2592",
    urls = ["https://github.com/johnynek/bazel-deps/archive/3fdaaa6de3ed8cf010a6b1713a04d55c4abb2592.zip"],    
)

load("//3rdparty:workspace.bzl", "maven_dependencies")

maven_dependencies()