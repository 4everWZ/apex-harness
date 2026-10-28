# Reviewer criteria

Do not supply this file to an executor.

Read the produced documents and compare their meaning with the currently supplied inputs. Record requirement coverage and concrete omissions; a reference back to an input without a maintained role does not by itself preserve the maintained contract. Complete formulas, state order, failure effects, comparison conditions, and acceptance boundaries matter more than wording or length. Distinguish accepted requirements from unchosen implementation, proposed research, and actual conformance.

Inspect layering as well as independent ownership. Product constraints, component interfaces, and algorithm/verification detail need usable levels of explanation: an overview cannot substitute for the detailed implementation contract. Check whether a developer can find that detail through the overview and whether cross-cutting constraints have a clear owner. Multiple files alone do not establish useful layers; do not require a ceremonial project specification or a separate file for every code module when it owns no distinct information.

For software, inspect how API consumers, independent worker implementers, and audit importers find and maintain the behavior they consume. Their distinct compatibility and acceptance boundaries must remain usable. For algorithm, inspect mathematical method semantics and the independently consumed evaluation protocol, including numeric and state-boundary cases. A single file or multiple files is not sufficient by itself to pass or fail: explain whether ownership and independent change are workable, whether content was compressed away, and whether any split serves an actual boundary. No fixed number of files, heading, matrix, or field is required.

Supply the second input only after preserving and reviewing the initial output. Inspect whether the API-only change preserves worker/audit versions, and whether the method change updates every dependent mathematical/acceptance condition while preserving evaluation definitions. Documentation-preparation cases provide no implementation conformance evidence.

Use the small case to detect the opposite failure: creating independently maintained contracts for internal stages that have no independent consumer or lifecycle. Check completeness there too.

Algorithm-build reuses the initial algorithm requirements with an implementation task, rather than an explicit documentation-preparation task. Review how specifications and unfinished evaluation work are maintained during actual development. Local detector tests are evidence about implementation only; they do not prove specification completeness or evaluation conformance.

Internal-algorithm removes the separate-provider and independent-version cues. Inspect whether shared product constraints and substantial feature, search, and persistence semantics still have usable technical layers. Do not treat a lack of separate teams as a reason to omit technical detail. Distinguish useful sections of a complete specification from an overloaded overview; record the actual choice and its usability rather than imposing a file-count threshold.

Also check that temporary input requirements remain unchanged, no experiment history is invented, no unrequested implementation is presented as accepted, and a plan does not become the sole owner of the accepted contract. Preserve a compact comparison record and the actual selected outputs needed to substantiate it. Structural checks are separate from this semantic review.
