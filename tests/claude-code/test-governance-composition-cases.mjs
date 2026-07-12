import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { resolveGovernance } from "./lib/governance-policy.mjs";

const here = path.dirname(fileURLToPath(import.meta.url));
const cases = JSON.parse(
  fs.readFileSync(path.join(here, "fixtures/governance-composition-cases.json"), "utf8"),
);

const byId = new Map(cases.map((item) => [item.id, item]));
const requiredIds = [
  "tier-c-local-edit",
  "tier-b-approved-inline",
  "tier-a-research-unapproved",
  "delegation-forbidden",
  "model-selector-unavailable",
  "edit-only-no-commit",
  "fresh-evidence-reuse",
  "evidence-invalidated",
];

function assert(condition, message) {
  if (!condition) throw new Error(message);
}

assert(cases.length === requiredIds.length, "fixture must contain exactly eight governance cases");
for (const id of requiredIds) assert(byId.has(id), `missing governance case: ${id}`);

for (const testCase of cases) {
  const actual = resolveGovernance(testCase.facts);
  assert(
    JSON.stringify(actual) === JSON.stringify(testCase.expected),
    `${testCase.id} mismatch\nexpected=${JSON.stringify(testCase.expected)}\nactual=${JSON.stringify(actual)}`,
  );
}

const availabilityOnly = resolveGovernance({
  gitAuthority: ["edit"],
  reviewerAvailable: true,
});
assert(
  availabilityOnly.reviewMode === undefined,
  "reviewer availability alone must not select code review",
);

const forbiddenDelegated = resolveGovernance({
  delegationAllowed: false,
  executionMode: "delegated",
  modelSelectorAvailable: false,
});
assert(forbiddenDelegated.executionMode === "inline", "delegation ceiling must force inline");
assert(forbiddenDelegated.includeModelParameter === undefined, "inline fallback must remove delegated-only model decisions");

const controllerCommit = resolveGovernance({
  requestedWorkflow: "sdd",
  delegationAllowed: true,
  controllerGitAuthority: ["edit", "stage", "commit"],
  delegatedGitAuthority: ["edit"],
  reviewSelected: true,
  reviewJustified: true,
  reviewerAvailable: true,
  delegatedRoles: ["implementer", "task-reviewer", "final-reviewer"],
  selectedMechanisms: ["delegation", "review"],
  workspaceClean: true,
});
assert(controllerCommit.selectCommitBasedSdd === true, "controller-commit SDD path should be selectable");
assert(controllerCommit.commitOwner === "controller", "controller should own commit without delegated commit authority");

const delegatedCommit = resolveGovernance({
  requestedWorkflow: "sdd",
  delegationAllowed: true,
  controllerGitAuthority: ["edit", "stage", "commit"],
  delegatedGitAuthority: ["edit", "stage", "commit"],
  reviewSelected: true,
  reviewJustified: true,
  reviewerAvailable: true,
  delegatedRoles: ["implementer", "task-reviewer", "final-reviewer"],
  selectedMechanisms: ["delegation", "review"],
  workspaceClean: true,
});
assert(delegatedCommit.commitOwner === "implementer", "explicit delegated commit authority should select implementer commit");

const insufficientController = resolveGovernance({
  requestedWorkflow: "sdd",
  delegationAllowed: true,
  controllerGitAuthority: ["commit"],
  delegatedGitAuthority: ["edit"],
  reviewSelected: true,
  reviewJustified: true,
  reviewerAvailable: true,
  delegatedRoles: ["implementer", "task-reviewer", "final-reviewer"],
  selectedMechanisms: ["delegation", "review"],
  workspaceClean: true,
});
assert(insufficientController.selectCommitBasedSdd === false, "commit-only controller authority must reject SDD");

const forbiddenSdd = resolveGovernance({
  requestedWorkflow: "sdd",
  delegationAllowed: false,
  controllerGitAuthority: ["edit", "stage", "commit"],
  delegatedGitAuthority: ["edit", "stage", "commit"],
  reviewSelected: true,
  reviewJustified: true,
  reviewerAvailable: true,
  delegatedRoles: ["implementer", "task-reviewer", "final-reviewer"],
  selectedMechanisms: ["delegation", "review"],
  workspaceClean: true,
});
assert(forbiddenSdd.executionMode === "inline", "forbidden SDD must remain inline");
assert(forbiddenSdd.selectCommitBasedSdd === false, "delegation ceiling must reject SDD selection");
assert(forbiddenSdd.commitOwner === "none", "rejected SDD must not assign commit ownership");

const validSddFacts = {
  requestedWorkflow: "sdd",
  delegationAllowed: true,
  controllerGitAuthority: ["edit", "stage", "commit"],
  delegatedGitAuthority: ["edit"],
  reviewSelected: true,
  reviewJustified: true,
  reviewerAvailable: true,
  delegatedRoles: ["implementer", "task-reviewer", "final-reviewer"],
  selectedMechanisms: ["delegation", "review"],
  workspaceClean: true,
};
for (const [label, override] of [
  ["missing delegation mechanism", { selectedMechanisms: ["review"] }],
  ["missing review mechanism", { selectedMechanisms: ["delegation"] }],
  ["dirty workspace", { workspaceClean: false }],
  ["unknown workspace state", { workspaceClean: undefined }],
  ["omitted delegation decision", { delegationAllowed: undefined }],
]) {
  const rejected = resolveGovernance({ ...validSddFacts, ...override });
  assert(rejected.selectCommitBasedSdd === false, `${label} must reject SDD`);
  assert(rejected.commitOwner === "none", `${label} must not assign commit ownership`);
}

console.log("STATUS: PASSED (governance composition fixtures and SDD boundaries)");
