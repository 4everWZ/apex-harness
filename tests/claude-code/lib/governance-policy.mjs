export function resolveGovernance(facts) {
  const result = {};
  const effectiveExecutionMode = facts.delegationAllowed === false
    ? "inline"
    : facts.executionMode;

  if (facts.risk === "C") {
    result.executionMode = "inline";
    result.mechanisms = [];
    result.verification = "focused";
    result.requiresCommit = false;
  }

  if (facts.risk === "B" && facts.designApproved && facts.delegationRequested === false) {
    result.executionMode = "inline";
    result.mechanisms = [];
    result.verification = "standard";
    result.repeatDesignApproval = false;
  }

  if (facts.risk === "A" && facts.researchSemanticsChange) {
    result.designGate = facts.designApproved ? "satisfied" : "required";
    result.verification = "critical";
    result.consultBeforeImplementation = !facts.designApproved;
    result.matrixConditionalOnTraceability = true;
  }

  if (facts.delegationAllowed === false) {
    result.executionMode = "inline";
    result.mechanismsExcluded = ["delegation", "parallel investigation"];
    result.delegatedGitAuthority = [];
  }

  if (effectiveExecutionMode === "delegated" && facts.modelSelectorAvailable === false) {
    result.includeModelParameter = false;
    result.recordRuntimeSelectedModel = true;
    result.guessAlternateApi = false;
  }

  if (Array.isArray(facts.gitAuthority) && facts.reviewSelected !== undefined) {
    const canEdit = facts.gitAuthority.includes("edit");
    const canCommit = facts.gitAuthority.includes("commit");
    if (canEdit && !canCommit) {
      result.executionMode = "inline";
      result.selectCommitBasedSdd = false;
      const mayReview = facts.reviewSelected === true
        && facts.reviewJustified === true
        && facts.delegationAllowed === true
        && facts.reviewerAvailable === true;
      result.reviewMode = mayReview ? "working-tree" : "none";
      result.requiresCommit = false;
    }
  }

  if (facts.requestedWorkflow === "sdd") {
    const controller = new Set(facts.controllerGitAuthority ?? []);
    const delegated = new Set(facts.delegatedGitAuthority ?? []);
    const roles = new Set(facts.delegatedRoles ?? []);
    const mechanisms = new Set(facts.selectedMechanisms ?? []);
    const controllerReady = ["edit", "stage", "commit"].every((permission) => controller.has(permission));
    const implementerCanEdit = delegated.has("edit");
    const reviewReady = facts.reviewSelected === true
      && facts.reviewJustified === true
      && facts.reviewerAvailable === true
      && roles.has("implementer")
      && roles.has("task-reviewer")
      && roles.has("final-reviewer");
    const workspaceReady = facts.workspaceClean === true;
    result.selectCommitBasedSdd = facts.delegationAllowed === true
      && controllerReady
      && implementerCanEdit
      && reviewReady
      && mechanisms.has("delegation")
      && mechanisms.has("review")
      && workspaceReady;
    result.commitOwner = !result.selectCommitBasedSdd
      ? "none"
      : delegated.has("stage") && delegated.has("commit")
        ? "implementer"
        : "controller";
  }

  if (facts.coverageMatchesFinalState === true && facts.claimCovered === true) {
    result.reuseEvidence = true;
    result.rerunBecauseAgentBoundary = false;
    result.runOnlyMissingChecks = true;
  }

  if (facts.coverageMatchesFinalState === false && facts.claimAffectedByChange === true) {
    result.reuseEvidence = false;
    result.rerunAffectedChecks = true;
    result.rerunUnrelatedFullSuite = false;
  }

  return result;
}
