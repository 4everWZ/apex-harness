# ReviewDesk specification

This document owns the accepted product contract. No acceptance of new requirements or implementation conformance follows from a requirements discussion alone.

## Users and scope

Writers submit articles; reviewers approve or return them. A user may hold both roles, but cannot review their own article. Users can access only their team's articles. Both the server and interface enforce these permissions.

The supported environment is desktop Chrome or Edge at a viewport width of at least 1024 pixels. Mobile layout is outside scope.

## Article workflow

Articles have Draft, Submitted, Approved and Returned states. Writers can edit their own Draft or Returned articles and submit them when title and body are nonempty. Submission changes the state to Submitted. Submitted articles cannot be edited. Reviewers can approve or return Submitted articles written by another team member. Approved is final. A return reason is currently optional.

While a submission or review action is pending, prevent duplicate activation. On failure keep the user's text and current committed state visible, and permit retry. A retry must not create duplicate submissions or audit events. A successful action commits its state change and audit event together, or neither.

The article list distinguishes loading, no results and load failure. Failure after a successful load retains the last loaded articles and exposes an error. Automatic refresh occurs every 30 seconds; requests do not overlap. Manual refresh remains available.

## Quality and acceptance

All workflow actions must be operable with the keyboard, and errors and pending states must be available to assistive technology. With the agreed H1 fixture of 200 articles, rendering after response data arrives must take no more than 500 ms; fetching time is excluded. No measurement result is supplied here.
