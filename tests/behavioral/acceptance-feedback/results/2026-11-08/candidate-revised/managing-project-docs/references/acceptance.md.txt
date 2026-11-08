# Acceptance and Feedback Lifecycle

## Choose the owner

Use a maintained acceptance owner when current results and valid feedback must remain usable across review or maintenance iterations. Reuse a suitable existing document, section, issue system or other owner. When none exists, use `docs/acceptance/<topic>.md` through the topology path rules. An ordinary single-session change does not by itself need this record.

The owner maintains the current acceptance conclusion, the checked scope and evidence references, and feedback that still needs handling. Specifications retain accepted requirements and display a brief conclusion with a direct reference. Plans or the task system own implementation arrangements; tests, CI and existing evidence systems own raw results. Reference existing issue and CI details rather than copying them into a second tracker. Where no other owner exists, keep the necessary information in the acceptance record.

## Handle feedback

- When implementation fails an accepted requirement, record the gap, correct the implementation and verify the affected behavior.
- When feedback proposes a new or changed requirement, keep it proposed until the normal acceptance process accepts it; then synchronize the specification before implementation and acceptance.
- When an opinion is unclear, keep the question with the acceptance or issue owner until it can be clarified and classified.

The agent handling feedback, implementing a change or performing acceptance updates the relevant owner and the affected specification summary before finishing that work. Reuse still-valid evidence alongside verification of affected changes. Keep the conclusion's scope clear, including remaining implementation or performance acceptance.

## Maintain and retire

Organize records by project or acceptance scope that genuinely needs separate maintenance, not by review round, date or check run. Update the same owner: replace superseded conclusions, consolidate repeated feedback, and remove detailed resolved discussion while retaining still-useful conclusions, constraints and evidence references. Git provides history.

A plan follows its own Goal. Its completion does not require closing unrelated feedback, and its retirement does not retire a useful acceptance owner. Before removing a plan, synchronize current conclusions and repair its references; cancelled work leaves its actual gaps visible without withdrawing accepted requirements.

Keep the acceptance owner while it serves continuing maintenance, even when no plan is open. When its scope moves, merges or ceases to apply and the owner loses its use, apply the topology retirement procedure: transfer still-valid information and required evidence, repair current references and apply the shared recovery protection.
